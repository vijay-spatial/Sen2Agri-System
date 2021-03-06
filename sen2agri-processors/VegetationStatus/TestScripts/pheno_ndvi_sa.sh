#! /bin/bash

CUR_DATE=`date +%Y-%m-%d`
FOLDER_NAME="pheno_${CUR_DATE}_1"

#add directories where products are to be found
/home/cudroiu/sen2agri/sen2agri-processors/VegetationStatus/TestScripts/pheno_processing.py --input \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20161206T080312_N0204_R035_T35JMK_20161206T081929.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161206.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20161216T080332_N0204_R035_T35JMK_20161216T081808.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161216.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20161223T075332_N0204_R135_T35JMK_20161223T080853.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161223.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170102T075322_N0204_R135_T35JMK_20170102T081146.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170102.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170112T075251_N0204_R135_T35JMK_20170112T081313.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170112.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170115T080251_N0204_R035_T35JMK_20170115T082622.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170115.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170201T075131_N0204_R135_T35JMK_20170201T081359.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170201.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170211T075031_N0204_R135_T35JMK_20170211T081229.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170211.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170214T080021_N0204_R035_T35JMK_20170214T082729.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170214.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170313T074931_N0204_R135_T35JMK_20170313T081339.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170313.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170316T075651_N0204_R035_T35JMK_20170316T081607.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170316.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170323T074601_N0204_R135_T35JMK_20170323T081539.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170323.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170402T074931_N0204_R135_T35JMK_20170402T081156.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170402.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170405T075611_N0204_R035_T35JMK_20170405T082306.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170405.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170412T074611_N0204_R135_T35JMK_20170412T081454.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170412.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170415T080001_N0204_R035_T35JMK_20170415T082345.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170415.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170422T074941_N0204_R135_T35JMK_20170422T081711.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170422.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_MSIL2A_20170425T075611_N0204_R035_T35JMK_20170425T082317.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20170425.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160706T170436_R135_V20160706T081431_20160706T081431.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160706.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160709T171751_R035_V20160709T082728_20160709T082728.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160709.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160716T152036_R135_V20160716T081239_20160716T081239.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160716.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160719T153131_R035_V20160719T082231_20160719T082231.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160719.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160729T152332_R035_V20160729T082733_20160729T082733.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160729.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160808T204036_R035_V20160808T082208_20160808T082208.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160808.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160816T222124_R135_V20160815T074942_20160815T081315.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160815.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160818T145713_R035_V20160818T075612_20160818T082401.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160818.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160825T144847_R135_V20160825T074612_20160825T081323.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160825.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160828T173553_R035_V20160828T080012_20160828T082322.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160828.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160904T170655_R135_V20160904T074942_20160904T081326.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160904.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160907T150016_R035_V20160907T075612_20160907T082430.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160907.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160914T123731_R135_V20160914T074612_20160914T081456.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160914.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160917T124707_R035_V20160917T080002_20160917T082222.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160917.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160917T143800_R035_V20160917T080002_20160917T082743.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160917.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160924T152310_R135_V20160924T074932_20160924T081448.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160924.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20160927T133808_R035_V20160927T075702_20160927T082120.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20160927.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20161007T175010_R035_V20161007T080002_20161007T082247.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161007.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20161014T202510_R135_V20161014T074932_20161014T081604.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161014.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20161018T221948_R035_V20161017T075922_20161017T082154.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161017.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20161020T165843_R135_V20161004T074742_20161004T074742.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161004.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20161025T015006_R135_V20161024T075002_20161024T075002.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161024.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20161028T222041_R035_V20161027T080022_20161027T080022.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161027.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20161103T171525_R135_V20161103T075102_20161103T075102.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161103.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20161115T003406_R135_V20161113T075152_20161113T075152.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161113.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20161116T145919_R035_V20161116T080212_20161116T080212.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161116.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20161125T170839_R135_V20161123T075232_20161123T075232.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161123.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20161128T225703_R035_V20161126T080252_20161126T080252.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161126.HDR" \
"/mnt/archive/maccs_def_slave/south_africa_pretoria/l2a/S2A_OPER_PRD_MSIL2A_PDMC_20161203T130412_R135_V20161203T075302_20161203T075302.SAFE/S2A_OPER_SSC_L2VALD_35JMK____20161203.HDR" \
--siteid 19 --resolution 10 --tileid "35JMK" --outdir /mnt/archive/test/L3B/Nigeria_Borno/${FOLDER_NAME} --mainmission SENTINEL
#end of USER modif
