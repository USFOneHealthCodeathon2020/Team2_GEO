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
