#include <QJsonDocument>
#include <QJsonObject>
#include <QRegularExpression>
#include <fstream>

#include "phenondvihandler.hpp"
#include "processorhandlerhelper.h"
#include "json_conversions.hpp"
#include "logger.hpp"

void PhenoNdviHandler::CreateTasksForNewProducts(QList<TaskToSubmit> &outAllTasksList,
                                                QList<std::reference_wrapper<const TaskToSubmit>> &outProdFormatterParentsList)
{
    outAllTasksList.append(TaskToSubmit{ "bands-extractor", {} });
    outAllTasksList.append(TaskToSubmit{ "feature-extraction", {outAllTasksList[0]} });
    outAllTasksList.append(TaskToSubmit{ "pheno-ndvi-metrics", {outAllTasksList[1]} });
    outAllTasksList.append(TaskToSubmit{ "pheno-ndvi-metrics-splitter", {outAllTasksList[2]} });

    // product formatter needs completion of pheno-ndvi-metrics-splitter
    outProdFormatterParentsList.append(outAllTasksList[3]);
}

void PhenoNdviHandler::HandleNewTilesList(EventProcessingContext &ctx,
                                          const JobSubmittedEvent &event, PhenoGlobalExecutionInfos &globalExecInfos,
                                          const TileTemporalFilesInfo &tileTemporalFilesInfo)
{
    QStringList listProducts = ProcessorHandlerHelper::GetTemporalTileFiles(tileTemporalFilesInfo);

    const auto &parameters = QJsonDocument::fromJson(event.parametersJson.toUtf8()).object();
    // Get the resolution value
    int resolution = 0;
    if(!GetParameterValueAsInt(parameters, "resolution", resolution) ||
            resolution == 0) {
        resolution = 10;    // TODO: We should configure the default resolution in DB
    }
    const auto &resolutionStr = QString::number(resolution);

    QList<TaskToSubmit> &allTasksList = globalExecInfos.allTasksList;
    QList<std::reference_wrapper<const TaskToSubmit>> &prodFormParTsksList = globalExecInfos.prodFormatParams.parentsTasksRef;
    CreateTasksForNewProducts(allTasksList, prodFormParTsksList);

    QList<std::reference_wrapper<TaskToSubmit>> allTasksListRef;
    for(TaskToSubmit &task: allTasksList) {
        allTasksListRef.append(task);
    }
    SubmitTasks(ctx, event.jobId, allTasksListRef);

    TaskToSubmit &bandsExtractorTask = allTasksList[0];
    TaskToSubmit &featureExtractionTask = allTasksList[1];
    TaskToSubmit &metricsEstimationTask = allTasksList[2];
    TaskToSubmit &metricsSplitterTask = allTasksList[3];

    const auto &rawReflBands = bandsExtractorTask.GetFilePath("reflectances.tif");
    const auto &allMasksImg = bandsExtractorTask.GetFilePath("mask_summary.tif");
    const auto &dates = bandsExtractorTask.GetFilePath("dates.txt");
    const auto &ndviImg = featureExtractionTask.GetFilePath("ndvi.tif");
    const auto &metricsEstimationImg = metricsEstimationTask.GetFilePath("metric_estimation.tif");
    const auto &metricsParamsImg = metricsSplitterTask.GetFilePath("metric_parameters_img.tif");
    const auto &metricsFlagsImg = metricsSplitterTask.GetFilePath("metric_flags_img.tif");

    QStringList bandsExtractorArgs = {
        "BandsExtractor", "-pixsize",   resolutionStr,  "-merge",    "true",     "-ndh", "true",
        "-out",           rawReflBands, "-allmasks", allMasksImg, "-outdate", dates,  "-il"
    };
    bandsExtractorArgs += listProducts;

    QStringList featureExtractionArgs = { "FeatureExtraction", "-rtocr", rawReflBands, "-ndvi", ndviImg };

    QStringList metricsEstimationArgs = {"PhenologicalNDVIMetrics",
        "-in", ndviImg, "-mask", allMasksImg, "-dates", dates, "-out", metricsEstimationImg
    };

    QStringList metricsSplitterArgs = { "PhenoMetricsSplitter",
                                        "-in", metricsEstimationImg,
                                        "-outparams", metricsParamsImg,
                                        "-outflags", metricsFlagsImg,
                                        "-compress", "1",
                                      };

    globalExecInfos.allStepsList = {
        bandsExtractorTask.CreateStep("BandsExtractor", bandsExtractorArgs),
        featureExtractionTask.CreateStep("FeatureExtraction", featureExtractionArgs),
        metricsEstimationTask.CreateStep("PhenologicalNDVIMetrics", metricsEstimationArgs),
        metricsSplitterTask.CreateStep("PhenoMetricsSplitter", metricsSplitterArgs),
    };

    PhenoProductFormatterParams &productFormatterParams = globalExecInfos.prodFormatParams;
    productFormatterParams.metricsParamsImg = metricsParamsImg;
    productFormatterParams.metricsFlagsImg = metricsFlagsImg;
}

void PhenoNdviHandler::HandleJobSubmittedImpl(EventProcessingContext &ctx,
                                              const JobSubmittedEvent &event)
{
    QStringList listProducts = GetL2AInputProductsTiles(ctx, event);
    if(listProducts.size() == 0) {
        ctx.MarkJobFailed(event.jobId);
        throw std::runtime_error(
            QStringLiteral("No products provided at input or no products available in the specified interval").
                    toStdString());
    }

    QMap<QString, TileTemporalFilesInfo> mapTiles = GroupTiles(ctx, event.siteId, event.jobId, listProducts, ProductType::L2AProductTypeId);
    QList<PhenoProductFormatterParams> listParams;

    TaskToSubmit productFormatterTask{"product-formatter", {}};
    NewStepList allSteps;
    //container for all task
    //QList<TaskToSubmit> allTasksList;
    QList<PhenoGlobalExecutionInfos> listPhenoInfos;
    for(auto tileId : mapTiles.keys())
    {
       const TileTemporalFilesInfo &listTemporalTiles = mapTiles.value(tileId);
       listPhenoInfos.append(PhenoGlobalExecutionInfos());
       PhenoGlobalExecutionInfos &infos = listPhenoInfos[listPhenoInfos.size()-1];
       infos.prodFormatParams.tileId = GetProductFormatterTile(tileId);
       HandleNewTilesList(ctx, event, infos, listTemporalTiles);
       listParams.append(infos.prodFormatParams);
       productFormatterTask.parentTasks += infos.prodFormatParams.parentsTasksRef;
       //allTasksList.append(infos.allTasksList);
       allSteps.append(infos.allStepsList);
    }

    SubmitTasks(ctx, event.jobId, {productFormatterTask});

    // finally format the product
    QStringList productFormatterArgs = GetProductFormatterArgs(productFormatterTask, ctx, event, listProducts, listParams);

    // add these steps to the steps list to be submitted
    allSteps.append(productFormatterTask.CreateStep("ProductFormatter", productFormatterArgs));
    ctx.SubmitSteps(allSteps);
}


void PhenoNdviHandler::HandleTaskFinishedImpl(EventProcessingContext &ctx,
                                              const TaskFinishedEvent &event)
{
    if (event.module == "product-formatter") {
        ctx.MarkJobFinished(event.jobId);

        QString prodName = GetProductFormatterProductName(ctx, event);
        QString productFolder = GetFinalProductFolder(ctx, event.jobId, event.siteId) + "/" + prodName;
        if(prodName != "" && ProcessorHandlerHelper::IsValidHighLevelProduct(productFolder)) {
            QString quicklook = GetProductFormatterQuicklook(ctx, event);
            QString footPrint = GetProductFormatterFootprint(ctx, event);
            // Insert the product into the database
            QDateTime minDate, maxDate;
            ProcessorHandlerHelper::GetHigLevelProductAcqDatesFromName(prodName, minDate, maxDate);
            ctx.InsertProduct({ ProductType::L3EProductTypeId, event.processorId, event.siteId,
                                event.jobId, productFolder, maxDate,
                                prodName, quicklook, footPrint, std::experimental::nullopt, TileIdList() });

            // Now remove the job folder containing temporary files
            RemoveJobFolder(ctx, event.jobId, "l3e");
        } else {
            Logger::error(QStringLiteral("Cannot insert into database the product with name %1 and folder %2").arg(prodName).arg(productFolder));
        }
    }
}

void PhenoNdviHandler::WriteExecutionInfosFile(const QString &executionInfosPath,
                                               const QStringList &listProducts)
{
    std::ofstream executionInfosFile;
    try {
        executionInfosFile.open(executionInfosPath.toStdString().c_str(), std::ofstream::out);
        executionInfosFile << "<?xml version=\"1.0\" ?>" << std::endl;
        executionInfosFile << "<metadata>" << std::endl;
        executionInfosFile << "  <General>" << std::endl;
        executionInfosFile << "  </General>" << std::endl;
        executionInfosFile << "  <XML_files>" << std::endl;
        for (int i = 0; i < listProducts.size(); i++) {
            executionInfosFile << "    <XML_" << std::to_string(i) << ">"
                               << listProducts[i].toStdString() << "</XML_" << std::to_string(i)
                               << ">" << std::endl;
        }
        executionInfosFile << "  </XML_files>" << std::endl;
        executionInfosFile << "</metadata>" << std::endl;
        executionInfosFile.close();
    } catch (...) {
    }
}

QStringList PhenoNdviHandler::GetProductFormatterArgs(TaskToSubmit &productFormatterTask, EventProcessingContext &ctx, const JobSubmittedEvent &event,
                                    const QStringList &listProducts, const QList<PhenoProductFormatterParams> &productParams) {
    const std::map<QString, QString> &configParameters = ctx.GetJobConfigurationParameters(event.jobId, "processor.l3b.");

    const auto &targetFolder = GetFinalProductFolder(ctx, event.jobId, event.siteId);
    const auto &outPropsPath = productFormatterTask.GetFilePath(PRODUCT_FORMATTER_OUT_PROPS_FILE);
    const auto &executionInfosPath = productFormatterTask.GetFilePath("executionInfos.txt");
    QStringList productFormatterArgs = { "ProductFormatter",
                                         "-destroot",
                                         targetFolder,
                                         "-fileclass", "OPER",
                                         "-level", "L3E",
                                         "-baseline", "01.00",
                                         "-siteid", QString::number(event.siteId),
                                         "-processor", "phenondvi",
                                         "-gipp", executionInfosPath,
                                         "-outprops", outPropsPath};
    productFormatterArgs += "-il";
    productFormatterArgs += listProducts;

    productFormatterArgs += "-processor.phenondvi.metrics";
    for(const PhenoProductFormatterParams &params: productParams) {
        productFormatterArgs += GetProductFormatterTile(params.tileId);
        productFormatterArgs += params.metricsParamsImg;
    }

    productFormatterArgs += "-processor.phenondvi.flags";
    for(const PhenoProductFormatterParams &params: productParams) {
        productFormatterArgs += GetProductFormatterTile(params.tileId);
        productFormatterArgs += params.metricsFlagsImg;
    }

    if (IsCloudOptimizedGeotiff(configParameters)) {
        productFormatterArgs += "-cog";
        productFormatterArgs += "1";
    }

    return productFormatterArgs;
}

ProcessorJobDefinitionParams PhenoNdviHandler::GetProcessingDefinitionImpl(SchedulingContext &ctx, int siteId, int scheduledDate,
                                                const ConfigurationParameterValueMap &requestOverrideCfgValues)
{
    ProcessorJobDefinitionParams params;
    params.isValid = false;

    QDateTime seasonStartDate;
    QDateTime seasonEndDate;
    // extract the scheduled date
    QDateTime qScheduledDate = QDateTime::fromTime_t(scheduledDate);
    GetSeasonStartEndDates(ctx, siteId, seasonStartDate, seasonEndDate, qScheduledDate, requestOverrideCfgValues);
    QDateTime limitDate = seasonEndDate.addMonths(2);
    if(qScheduledDate > limitDate) {
        return params;
    }

    ConfigurationParameterValueMap mapCfg = ctx.GetConfigurationParameters(QString("processor.l3e."), siteId, requestOverrideCfgValues);
    // we might have an offset in days from starting the downloading products to start the L3E production
    int startSeasonOffset = mapCfg["processor.l3e.start_season_offset"].value.toInt();
    seasonStartDate = seasonStartDate.addDays(startSeasonOffset);

    // Get the start and end date for the production
    QDateTime endDate = qScheduledDate;
    QDateTime startDate = seasonStartDate;

    params.productList = ctx.GetProducts(siteId, (int)ProductType::L2AProductTypeId, startDate, endDate);
    // Normally for PhenoNDVI we need at least 4 products available in order to be able to create a L3E product
    // but if we do not return here, the schedule block waiting for products (that might never happen)
    bool waitForAvailProcInputs = (mapCfg["processor.l3e.sched_wait_proc_inputs"].value.toInt() != 0);
    if((waitForAvailProcInputs == false) || (params.productList.size() >= 4)) {
        params.isValid = true;
        Logger::debug(QStringLiteral("Executing scheduled job. Scheduler extracted for L3E a number "
                                     "of %1 products for site ID %2 with start date %3 and end date %4!")
                      .arg(params.productList.size())
                      .arg(siteId)
                      .arg(startDate.toString())
                      .arg(endDate.toString()));
    } else {
        Logger::debug(QStringLiteral("Scheduled job for L3E and site ID %1 with start date %2 and end date %3 "
                                     "will not be executed (no products)!")
                      .arg(siteId)
                      .arg(startDate.toString())
                      .arg(endDate.toString()));
    }

    return params;
}
