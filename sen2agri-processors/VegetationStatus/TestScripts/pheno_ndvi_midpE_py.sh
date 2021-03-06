#! /bin/bash

#USER modif
#add directories where SPOT products are to be found
./pheno_processing.py --applocation ~/sen2agri-processors-build --input \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130217_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130217_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130222_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130222_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130227_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130227_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130304_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130304_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130319_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130319_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130324_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130324_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130329_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130329_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130403_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130403_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130413_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130413_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130418_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130418_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130423_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130423_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130503_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130503_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130513_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130513_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130518_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130518_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130523_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130523_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130602_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130602_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130607_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130607_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130612_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130612_N2A_CSudmipy-ED0000B0000.xml" \
"/mnt/Sen2Agri_DataSets/L2A/Spot4-T5/Sudmipy-East/SPOT4_HRVIR1_XS_20130617_N2A_CSudmipy-ED0000B0000/SPOT4_HRVIR1_XS_20130617_N2A_CSudmipy-ED0000B0000.xml" \
--resolution 20 --outdir /mnt/data/L3B/SPOT4-T5/Midp_E/pheno-2015-12-21
#end of USER modif
