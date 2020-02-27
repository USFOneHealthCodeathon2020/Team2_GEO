/*
Version   Author	       Start Date         Last Update
---    	---------------    ------------       ---------------
1.0     Linh Duong         02/26/2020			02/26/2020

*/

libname IN "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip\aff_download_zip";
libname OUT "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip\aff_download_zip";

Proc import datafile = "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip\aff_download_zip\ACS_17_5YR_B01001_with_ann.csv"
out = One dbms=csv replace;
getnames=yes; datarow = 3;
run;

Proc import datafile = "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip\aff_download_zip\ACS_17_5YR_B02001_with_ann.csv"
out = Two dbms=csv replace;
getnames=yes; datarow = 3;
run;

Proc import datafile = "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip\aff_download_zip\ACS_17_5YR_B03003_with_ann.csv"
out = Three dbms=csv replace;
getnames=yes; datarow = 3;
run;

Proc import datafile = "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip\aff_download_zip\ACS_17_5YR_B08101_with_ann.csv"
out = Four dbms=csv replace;
getnames=yes; datarow = 3;
run;

Proc import datafile = "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip\aff_download_zip\ACS_17_5YR_S0101_with_ann.csv"
out = Five dbms=csv replace;
getnames=yes; datarow = 3; 
run;

Proc import datafile = "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip\aff_download_zip\ACS_17_5YR_S1501_with_ann.csv"
out = Six dbms=csv replace;
getnames=yes; datarow = 3;
run;

Proc import datafile = "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip\aff_download_zip\ACS_17_5YR_S1701_with_ann.csv"
out = Seven dbms=csv replace;
getnames=yes; datarow = 3; 
run;

Proc import datafile = "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip\aff_download_zip\ACS_17_5YR_S2301_with_ann.csv"
out = Eight dbms=csv replace;
getnames=yes; datarow = 3;
run;


Data OneB;
Set One;
keep HD01_VD02 HD01_VD26 GEO_display_label;
run;

Data OneC;
Set OneB;
rename HD01_VD02 = Male;
rename HD01_VD26 = Female;
run;

Data TwoB;
Set Two;
keep HD02_VD02 HD01_VD03 HD01_VD04 HD01_VD05 HD01_VD06 HD01_VD07 HD01_VD08 GEO_display_label;
run;

Data TwoC;
Set TwoB;
rename HD02_VD02 = White;
rename HD01_VD03 = Black;
rename HD01_VD04 = American_Indian_Alaska_Native;
rename HD01_VD05 = Asian;
rename HD01_VD06 = Native_Hawaiian_Pacific_Islander;
rename HD01_VD07 = Other_Race;
rename HD01_VD08 = Two_Or_More_Races;
run;

Data ThreeB;
Set Three;
keep HD01_VD02 HD01_VD03 GEO_display_label;
run;

Data ThreeC;
Set ThreeB;
rename HD01_VD02 = Not_Hispanic_or_Latino;
rename HD01_VD03 = Hispanic_or_Latino;
run;

Data FourB;
Set Four;
keep HD01_VD10 HD01_VD18 HD01_VD26 HD01_VD34  HD01_VD42 HD01_VD50 GEO_display_label;
run;

Data FourC;
Set FourB;
rename HD01_VD10 = drove_car_or_truck_or_van; 
rename HD01_VD18 = carpool_car_or_truck_or_van;
rename HD01_VD26 = public_transport_exclude_taxi;
rename HD01_VD34 = walked;
rename HD01_VD42 = Taxi_motorcycle_bicycle_other;
rename HD01_VD50 = worked_at_home;
run;

Data FiveB;
Set Five;
keep HC01_EST_VC01 GEO_display_label;
run;

Data FiveC;
Set FiveB;
rename HC01_EST_VC01 = total_pop;
run;

Data SixB;
Set Six;
keep HC02_EST_VC17 HC02_EST_VC18 GEO_display_label;
run;

Data SixC;
Set SixB;
rename HC02_EST_VC17 = percent_high_school_or_higher;
rename HC02_EST_VC18 = percent_bachelors_or_higher;
run;

Data SevenB;
Set Seven;
keep HC03_EST_VC01 GEO_display_label;
run;

Data SevenC;
Set SevenB;
rename HC03_EST_VC01 = percent_below_poverty_level;
run;

Data EightB;
Set Eight;
keep HC04_EST_VC01 GEO_display_label;
run;

Data EightC;
Set EightB;
rename HC04_EST_VC01 = unemployment_rate_16_older;
run;

*Merge Data;

Data ACS;
Merge OneC TwoC ThreeC FourC FiveC SixC SevenC EightC;
by GEO_display_label;
run; 

*Export to Excel;
PROC EXPORT DATA= ACS

             OUTFILE= "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip\ACS2013_2017_Data.XLSX"

             DBMS=xlsx REPLACE;

      SHEET="ACS_Data";

RUN;






















Data OneB;
Set One;
drop HD02_VD01 HD02_VD03 HD02_VD04 HD02_VD05 HD02_VD06 HD02_VD07 HD02_VD08 HD02_VD09 HD02_VD10 HD02_VD11 HD02_VD12 HD02_VD13 HD02_VD14 HD02_VD15 HD02_VD16 HD02_VD17 HD02_VD18 HD02_VD19 
HD02_VD20 HD02_VD21 HD02_VD22 HD02_VD23 HD02_VD24 HD02_VD25 HD02_VD26 HD02_VD27 HD02_VD28 HD02_VD29 HD02_VD30 HD02_VD31 HD02_VD32 HD02_VD33 HD02_VD34 HD02_VD35 HD02_VD36 HD02_VD37 
HD02_VD38 HD02_VD39 HD02_VD40 HD02_VD41 HD02_VD42 HD02_VD43 HD02_VD44 HD02_VD45 HD02_VD46 HD02_VD47 HD02_VD48 HD02_VD49 HD02_VD50 HD02_VD51 HD02_VD52 HD02_VD53 HD02_VD54 HD02_VD55 
HD02_VD56 HD02_VD57;
run;

Data TwoB;
Set Two;
drop HD02_VD01 HD02_VD03 HD02_VD04 HD02_VD05 HD02_VD06 HD02_VD07 HD02_VD08 HD02_VD09 HD02_VD10 HD02_VD11 HD02_VD12 HD02_VD13 HD02_VD14 HD02_VD15 HD02_VD16 HD02_VD17 HD02_VD18 HD02_VD19 
HD02_VD20 HD02_VD21 HD02_VD22 HD02_VD23 HD02_VD24 HD02_VD25 HD02_VD26 HD02_VD27 HD02_VD28 HD02_VD29 HD02_VD30 HD02_VD31 HD02_VD32 HD02_VD33 HD02_VD34 HD02_VD35 HD02_VD36 HD02_VD37 
HD02_VD38 HD02_VD39 HD02_VD40 HD02_VD41 HD02_VD42 HD02_VD43 HD02_VD44 HD02_VD45 HD02_VD46 HD02_VD47 HD02_VD48 HD02_VD49 HD02_VD50 HD02_VD51 HD02_VD52 HD02_VD53 HD02_VD54 HD02_VD55 
HD02_VD56 HD02_VD57;
run;

Data ThreeB;
Set Three;
drop HD02_VD01 HD02_VD03 HD02_VD04 HD02_VD05 HD02_VD06 HD02_VD07 HD02_VD08 HD02_VD09 HD02_VD10 HD02_VD11 HD02_VD12 HD02_VD13 HD02_VD14 HD02_VD15 HD02_VD16 HD02_VD17 HD02_VD18 HD02_VD19 
HD02_VD20 HD02_VD21 HD02_VD22 HD02_VD23 HD02_VD24 HD02_VD25 HD02_VD26 HD02_VD27 HD02_VD28 HD02_VD29 HD02_VD30 HD02_VD31 HD02_VD32 HD02_VD33 HD02_VD34 HD02_VD35 HD02_VD36 HD02_VD37 
HD02_VD38 HD02_VD39 HD02_VD40 HD02_VD41 HD02_VD42 HD02_VD43 HD02_VD44 HD02_VD45 HD02_VD46 HD02_VD47 HD02_VD48 HD02_VD49 HD02_VD50 HD02_VD51 HD02_VD52 HD02_VD53 HD02_VD54 HD02_VD55 
HD02_VD56 HD02_VD57;
run;

Data FourB;
Set Four;
drop HD02_VD01 HD02_VD03 HD02_VD04 HD02_VD05 HD02_VD06 HD02_VD07 HD02_VD08 HD02_VD09 HD02_VD10 HD02_VD11 HD02_VD12 HD02_VD13 HD02_VD14 HD02_VD15 HD02_VD16 HD02_VD17 HD02_VD18 HD02_VD19 
HD02_VD20 HD02_VD21 HD02_VD22 HD02_VD23 HD02_VD24 HD02_VD25 HD02_VD26 HD02_VD27 HD02_VD28 HD02_VD29 HD02_VD30 HD02_VD31 HD02_VD32 HD02_VD33 HD02_VD34 HD02_VD35 HD02_VD36 HD02_VD37 
HD02_VD38 HD02_VD39 HD02_VD40 HD02_VD41 HD02_VD42 HD02_VD43 HD02_VD44 HD02_VD45 HD02_VD46 HD02_VD47 HD02_VD48 HD02_VD49 HD02_VD50 HD02_VD51 HD02_VD52 HD02_VD53 HD02_VD54 HD02_VD55 
HD02_VD56 HD02_VD57;
run;

Data FiveB;
Set Five;
drop HD02_VD01 HD02_VD03 HD02_VD04 HD02_VD05 HD02_VD06 HD02_VD07 HD02_VD08 HD02_VD09 HD02_VD10 HD02_VD11 HD02_VD12 HD02_VD13 HD02_VD14 HD02_VD15 HD02_VD16 HD02_VD17 HD02_VD18 HD02_VD19 
HD02_VD20 HD02_VD21 HD02_VD22 HD02_VD23 HD02_VD24 HD02_VD25 HD02_VD26 HD02_VD27 HD02_VD28 HD02_VD29 HD02_VD30 HD02_VD31 HD02_VD32 HD02_VD33 HD02_VD34 HD02_VD35 HD02_VD36 HD02_VD37 
HD02_VD38 HD02_VD39 HD02_VD40 HD02_VD41 HD02_VD42 HD02_VD43 HD02_VD44 HD02_VD45 HD02_VD46 HD02_VD47 HD02_VD48 HD02_VD49 HD02_VD50 HD02_VD51 HD02_VD52 HD02_VD53 HD02_VD54 HD02_VD55 
HD02_VD56 HD02_VD57;
run;

Data SixB;
Set Six;
drop HD02_VD01 HD02_VD03 HD02_VD04 HD02_VD05 HD02_VD06 HD02_VD07 HD02_VD08 HD02_VD09 HD02_VD10 HD02_VD11 HD02_VD12 HD02_VD13 HD02_VD14 HD02_VD15 HD02_VD16 HD02_VD17 HD02_VD18 HD02_VD19 
HD02_VD20 HD02_VD21 HD02_VD22 HD02_VD23 HD02_VD24 HD02_VD25 HD02_VD26 HD02_VD27 HD02_VD28 HD02_VD29 HD02_VD30 HD02_VD31 HD02_VD32 HD02_VD33 HD02_VD34 HD02_VD35 HD02_VD36 HD02_VD37 
HD02_VD38 HD02_VD39 HD02_VD40 HD02_VD41 HD02_VD42 HD02_VD43 HD02_VD44 HD02_VD45 HD02_VD46 HD02_VD47 HD02_VD48 HD02_VD49 HD02_VD50 HD02_VD51 HD02_VD52 HD02_VD53 HD02_VD54 HD02_VD55 
HD02_VD56 HD02_VD57;
run;

Data SevenB;
Set Seven;
drop HD02_VD01 HD02_VD03 HD02_VD04 HD02_VD05 HD02_VD06 HD02_VD07 HD02_VD08 HD02_VD09 HD02_VD10 HD02_VD11 HD02_VD12 HD02_VD13 HD02_VD14 HD02_VD15 HD02_VD16 HD02_VD17 HD02_VD18 HD02_VD19 
HD02_VD20 HD02_VD21 HD02_VD22 HD02_VD23 HD02_VD24 HD02_VD25 HD02_VD26 HD02_VD27 HD02_VD28 HD02_VD29 HD02_VD30 HD02_VD31 HD02_VD32 HD02_VD33 HD02_VD34 HD02_VD35 HD02_VD36 HD02_VD37 
HD02_VD38 HD02_VD39 HD02_VD40 HD02_VD41 HD02_VD42 HD02_VD43 HD02_VD44 HD02_VD45 HD02_VD46 HD02_VD47 HD02_VD48 HD02_VD49 HD02_VD50 HD02_VD51 HD02_VD52 HD02_VD53 HD02_VD54 HD02_VD55 
HD02_VD56 HD02_VD57;
run;

Data EightB;
Set Eight;
drop HD02_VD01 HD02_VD03 HD02_VD04 HD02_VD05 HD02_VD06 HD02_VD07 HD02_VD08 HD02_VD09 HD02_VD10 HD02_VD11 HD02_VD12 HD02_VD13 HD02_VD14 HD02_VD15 HD02_VD16 HD02_VD17 HD02_VD18 HD02_VD19 
HD02_VD20 HD02_VD21 HD02_VD22 HD02_VD23 HD02_VD24 HD02_VD25 HD02_VD26 HD02_VD27 HD02_VD28 HD02_VD29 HD02_VD30 HD02_VD31 HD02_VD32 HD02_VD33 HD02_VD34 HD02_VD35 HD02_VD36 HD02_VD37 
HD02_VD38 HD02_VD39 HD02_VD40 HD02_VD41 HD02_VD42 HD02_VD43 HD02_VD44 HD02_VD45 HD02_VD46 HD02_VD47 HD02_VD48 HD02_VD49 HD02_VD50 HD02_VD51 HD02_VD52 HD02_VD53 HD02_VD54 HD02_VD55 
HD02_VD56 HD02_VD57;
run;




