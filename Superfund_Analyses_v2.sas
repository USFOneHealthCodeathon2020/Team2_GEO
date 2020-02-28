/*
Version   Author	       Start Date         Last Update
---    	---------------    ------------       ---------------
1.0     Linh Duong         02/27/2020			02/27/2020

*/

PROC IMPORT OUT= WORK.Superfund_Data DATAFILE= "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\SuperFund Data\Superfund_final_dataset.csv"
 DBMS=CSV REPLACE; GETNAMES=YES;  
RUN; 

Proc freq data = superfund_data;
tables Fiscal_Year;
run;

Proc freq data = superfund_data;
tables Contaminant_Name;
run;

Proc freq data = superfund_data;
tables EPA_ID;
run;

Data superfund_data2;
Set superfund_data;
if 1982 <= Fiscal_Year <= 1987 then Year=1;
else if 1988 <= Fiscal_Year <= 1992 then Year=2;
else if 1993 <= Fiscal_Year <= 1997 then Year=3;
else if 1988 <= Fiscal_Year <= 2002 then Year=4;
else if 2003 <= Fiscal_Year <= 2007 then Year=5;
else if 2008 <= Fiscal_Year <= 2012 then Year=6;
else if Fiscal_Year >= 2013 then Year=7;
if Contaminant_Name = "ARSENIC" then ARSENIC = 1;
else ARSENIC = 0;
if Contaminant_Name = "BENZENE" then BENZENE = 1;
else BENZENE = 0;
if Contaminant_Name = "BENZO(B)FLUORANTHENE" then BENZO_B_FLUORANTHENE = 1;
else BENZO_B_FLUORANTHENE = 0;
if Contaminant_Name = "BENZO[A]PYRENE" then BENZO_A_PYRENE = 1;
else BENZO_A_PYRENE = 0;
if Contaminant_Name = "CADMIUM" then CADMIUM = 1;
else CADMIUM = 0;
if Contaminant_Name = "CHLOROETHENE (VINYL CHLORIDE)" then CVC = 1;
else CVC = 0;
if Contaminant_Name = "CHLOROFORM" then CHLOROFORM = 1;
else CHLOROFORM = 0;
if Contaminant_Name = "LEAD" then LEAD = 1;
else LEAD = 0;
if Contaminant_Name = "MERCURY" then MERCURY = 1;
else MERCURY = 0;
if Contaminant_Name = "POLYCHLORINATED BIPHENYLS (PCBs)" then PCBs = 1;
else PCBs = 0;
if Contaminant_Name = "POLYCYCLIC AROMATIC HYDROCARBONS (PAHS)" then PAHS = 1;
else PAHS = 0;
run;

proc freq data = superfund_data2 noprint;
tables ARSENIC / out= superfund_data3;
by zip_code;
run;

*Re-label Variables;
Data A;
Set superfund_data3;
rename count = num_ARSENIC;
label count = "num_ARSENIC";
drop percent;
run;

proc freq data = superfund_data2 noprint;
tables BENZENE / out= superfund_data4;
by zip_code;
run;

*Re-label Variables;
Data B;
Set superfund_data4;
rename count = num_BENZENE;
label count = "num_BENZENE";
drop percent;
run;

proc freq data = superfund_data2 noprint;
tables BENZO_B_FLUORANTHENE / out= superfund_data5;
by zip_code;
run;

*Re-label Variables;
Data C;
Set superfund_data5;
rename count = num_BENZO_B_FLUORANTHENE;
label count = "num_BENZO_B_FLUORANTHENE";
drop percent;
run;

proc freq data = superfund_data2 noprint;
tables BENZO_A_PYRENE / out= superfund_data6;
by zip_code;
run;

*Re-label Variables;
Data D;
Set superfund_data6;
rename count = num_BENZO_A_PYRENE;
label count = "num_BENZO_A_PYRENE";
drop percent;
run;

proc freq data = superfund_data2 noprint;
tables CADMIUM / out= superfund_data7;
by zip_code;
run;

*Re-label Variables;
Data E;
Set superfund_data7;
rename count = num_CADMIUM;
label count = "num_CADMIUM";
drop percent;
run;

proc freq data = superfund_data2 noprint;
tables CVC / out= superfund_data8;
by zip_code;
run;

*Re-label Variables;
Data F;
Set superfund_data8;
rename count = num_CVC;
label count = "num_CVC";
drop percent;
run;

proc freq data = superfund_data2 noprint;
tables CHLOROFORM / out= superfund_data9;
by zip_code;
run;

*Re-label Variables;
Data G;
Set superfund_data9;
rename count = num_CHLOROFORM;
label count = "num_CHLOROFORM";
drop percent;
run;

proc freq data = superfund_data2 noprint;
tables LEAD / out= superfund_data10;
by zip_code;
run;

*Re-label Variables;
Data H;
Set superfund_data10;
rename count = num_LEAD;
label count = "num_LEAD";
drop percent;
run;

proc freq data = superfund_data2 noprint;
tables MERCURY / out= superfund_data11;
by zip_code;
run;

*Re-label Variables;
Data I;
Set superfund_data11;
rename count = num_MERCURY;
label count = "num_MERCURY";
drop percent;
run;

proc freq data = superfund_data2 noprint;
tables PCBs / out= superfund_data12;
by zip_code;
run;

*Re-label Variables;
Data J;
Set superfund_data12;
rename count = num_PCBs;
label count = "num_PCBs";
drop percent;
run;

proc freq data = superfund_data2 noprint;
tables PAHS / out= superfund_data13;
by zip_code;
run;

*Re-label Variables;
Data K;
Set superfund_data13;
rename count = num_PAHS;
label count = "num_PAHS";
drop percent;
run;

*Merge Chemicals into One Dataset;

Data Superfund_data14;
Merge  A B C D E F G H I J K;
by zip_code;
run; 

*Create percentages for Chemicals;
Data L;
Set Superfund_data14;
Total_Chem = num_ARSENIC + num_BENZENE + num_BENZO_B_FLUORANTHENE + num_BENZO_A_PYRENE + num_CADMIUM + num_CVC + num_CHLOROFORM + num_LEAD + num_MERCURY + num_PCBs + num_PAHS;
Pct_ARSENIC = (divide(num_ARSENIC,Total_Chem))*100;
Pct_BENZENE = (divide(num_BENZENE,Total_Chem))*100;
Pct_BENZO_B_FLUORANTHENE = (divide(num_BENZO_B_FLUORANTHENE,Total_Chem))*100;
Pct_BENZO_A_PYRENE = (divide(num_BENZO_A_PYRENE,Total_Chem))*100;
Pct_CADMIUM = (divide(num_CADMIUM,Total_Chem))*100;
Pct_CVC = (divide(num_CVC,Total_Chem))*100;
Pct_CHLOROFORM = (divide(num_CHLOROFORM,Total_Chem))*100;
Pct_LEAD = (divide(num_LEAD,Total_Chem))*100;
Pct_MERCURY = (divide(num_MERCURY,Total_Chem))*100;
Pct_PCBs = (divide(num_PCBs,Total_Chem))*100;
Pct_PAHS = (divide(num_PAHS,Total_Chem))*100;
run;

Data superfund_data15;
Merge superfund_data2 L;
by zip_code;
run; 

Data One;
Set superfund_data15;
if Year = 1 then Year_One = 1;
else Year_One = 0;
if Year = 2 then Year_Two = 1;
else Year_Two = 0;
if Year = 3 then Year_Three = 1;
else Year_Three = 0;
if Year = 4 then Year_Four = 1;
else Year_Four = 0;
if Year = 5 then Year_Five = 1;
else Year_Five = 0;
if Year = 6 then Year_Six = 1;
else Year_Six = 0;
if Year = 7 then Year_Seven = 1;
else Year_Seven = 0;
run;

proc freq data = One;
tables Year Year_One Year_Two Year_Three Year_Four Year_Five Year_Six Year_Seven;
run;

*Year_One Map;

Data Year_One_Map;
Set One;
where Year_One = 1;
drop Year Year_Two Year_Three Year_Four Year_Five Year_Six Year_Seven;
run;

*Year_Two Map;
Data Year_Two_Map;
Set One;
where Year_Two = 1;
drop Year Year_One Year_Three Year_Four Year_Five Year_Six Year_Seven;
run;

*Year_Three Map;
Data Year_Three_Map;
Set One;
where Year_Three = 1;
drop Year Year_One Year_Two Year_Four Year_Five Year_Six Year_Seven;
run;

*Year_Four Map;
Data Year_Four_MAp;
Set One;
where Year_Four = 1;
drop Year Year_One Year_Two Year_Three Year_Five Year_Six Year_Seven;
run;

*Year_Five Map;
Data Year_Five_Map;
Set One;
where Year_Five = 1;
drop Year Year_One Year_Two Year_Three Year_Four Year_Six Year_Seven;
run;

*Year_Six Map;
Data Year_Six_Map;
Set One;
where Year_Six = 1;
drop Year Year_One Year_Two Year_Three Year_Four Year_Five Year_Seven;
run;

*Year_Seven Map;
Data Year_Seven_Map;
Set One;
where Year_Seven = 1;
drop Year Year_One Year_Two Year_Three Year_Four Year_Five Year_Six;
run;

*Export to Excel;
PROC EXPORT DATA= Year_One_Map

             OUTFILE= "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\Superfund Data\Superfund cleaned data\Superfund_Year_Cat_One.XLSX"

             DBMS=xlsx REPLACE;

      SHEET="Superfund_Year_Cat_One";

RUN;

*Export to Excel;
PROC EXPORT DATA= Year_Two_Map

             OUTFILE= "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\Superfund Data\Superfund cleaned data\Superfund_Year_Cat_Two.XLSX"

             DBMS=xlsx REPLACE;

      SHEET="Superfund_Year_Cat_Two";

RUN;

*Export to Excel;
PROC EXPORT DATA= Year_Three_Map

             OUTFILE= "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\Superfund Data\Superfund cleaned data\Superfund_Year_Cat_Three.XLSX"

             DBMS=xlsx REPLACE;

      SHEET="Superfund_Year_Cat_Three";

RUN;

*Export to Excel;
PROC EXPORT DATA= Year_Four_Map

             OUTFILE= "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\Superfund Data\Superfund cleaned data\Superfund_Year_Cat_Four.XLSX"

             DBMS=xlsx REPLACE;

      SHEET="Superfund_Year_Cat_Four";

RUN;

*Export to Excel;
PROC EXPORT DATA= Year_Five_Map

             OUTFILE= "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\Superfund Data\Superfund cleaned data\Superfund_Year_Cat_Five.XLSX"

             DBMS=xlsx REPLACE;

      SHEET="Superfund_Year_Cat_Five";

RUN;

*Export to Excel;
PROC EXPORT DATA= Year_Six_Map

             OUTFILE= "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\Superfund Data\Superfund cleaned data\Superfund_Year_Cat_Six.XLSX"

             DBMS=xlsx REPLACE;

      SHEET="Superfund_Year_Cat_Six";

RUN;

*Export to Excel;
PROC EXPORT DATA= Year_Seven_Map

             OUTFILE= "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\Superfund Data\Superfund cleaned data\Superfund_Year_Cat_Seven.XLSX"

             DBMS=xlsx REPLACE;

      SHEET="Superfund_Year_Cat_Seven";

RUN;
