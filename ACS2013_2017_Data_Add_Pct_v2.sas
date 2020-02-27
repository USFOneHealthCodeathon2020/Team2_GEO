/*
Version   Author	       Start Date         Last Update
---    	---------------    ------------       ---------------
1.0     Linh Duong         02/27/2020			02/27/2020

*/

PROC IMPORT OUT= WORK.ACS_Data DATAFILE= "C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip/ACS2013_2017_Data.xlsx" 
            DBMS=xlsx REPLACE;
     SHEET="ACS_Data"; 
     GETNAMES=YES;
RUN;

Data ACS_Data2;
set ACS_Data;
rename American_Indian_Alaska_Native = AI_AN;
rename Native_Hawaiian_Pacific_Islander = Nat_Haw_Pac_Islan;
rename public_transport_exclude_taxi = public_transport_excl_taxi;
rename Taxi_motorcycle_bicycle_other = Taxi_motorcycle_bicyc_other;
run;

Data ACS_Data3;
set ACS_Data2;
Total_Sex = Male + Female;
Pct_Male = (divide(Male,Total_Sex))*100;
Pct_Female = (divide(Female,Total_Sex))*100;
Total_Race = White + Black + AI_AN + Asian + Nat_Haw_Pac_Islan + Other_Race + Two_Or_More_Races;
Pct_White = (divide(White,Total_Race))*100;
Pct_Black = (divide(Black,Total_Race))*100;
Pct_AI_AN = (divide(AI_AN,Total_Race))*100;
Pct_Asian = (divide(Asian,Total_Race))*100;
Pct_Nat_Haw_Pac_Islan = (divide(Nat_Haw_Pac_Islan,Total_Race))*100;
Pct_Other_Race = (divide(Other_Race,Total_Race))*100;
Pct_Two_Or_More_Races = (divide(Two_Or_More_Races,Total_Race))*100;
Total_Ethnicity = Hispanic_or_Latino + Not_Hispanic_or_Latino;
Pct_Hispanic_or_Latino = (divide(Hispanic_or_Latino,Total_Ethnicity))*100;
Pct_Not_Hispanic_or_Latino = (divide(Not_Hispanic_or_Latino,Total_Ethnicity))*100;
Type_of_transportation = drove_car_or_truck_or_van + carpool_car_or_truck_or_van + public_transport_excl_taxi + walked + Taxi_motorcycle_bicyc_other + worked_at_home;
Pct_drove_car_or_truck_or_van = (divide(drove_car_or_truck_or_van,Type_of_transportation))*100;
Pct_carpool_car_or_truck_or_van = (divide(carpool_car_or_truck_or_van,Type_of_transportation))*100;
Pct_public_transport_excl_taxi = (divide(public_transport_excl_taxi,Type_of_transportation))*100;
Pct_walked = (divide(walked,Type_of_transportation))*100;
Pct_Taxi_motorcycle_bicyc_other = (divide(Taxi_motorcycle_bicyc_other,Type_of_transportation))*100;
Pct_worked_at_home = (divide(worked_at_home,Type_of_transportation))*100;
run;

dm "dexport ACS_Data3 'C:\Users\lduon\Desktop\USF PhD Program\2020 One Health Codeathon - Host-Microbiome Interactions in Global Health\ACS_Data_Zip\ACS2013_2017_Data_Add_Pct_v2.csv' ";
