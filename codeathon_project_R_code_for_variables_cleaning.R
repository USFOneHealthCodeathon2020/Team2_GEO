df1=read.csv("C:\\Users\\jdahr\\Desktop\\Genomics_Hub\\Codeathon\\ag-pgp-hmp-gg-cleaned-usonly.csv")


# extract columns of interest
library(dplyr)
library(dplyr)
newdata=df1 %>% select("SEX","AGE_CAT","ECONOMIC_REGION","ANTIBIOTIC_HISTORY","CENSUS_REGION","LEVEL_OF_EDUCATION","RACE","BMI","SMOKING_FREQUENCY","SAMPLE_TYPE","latitude","longitude","DRINKING_WATER_SOURCE","EXERCISE_LOCATION","ONE_LITER_OF_WATER_A_DAY_FREQUENCY")

#plot columns of interest with responses and missing values  with VIM

library("VIM")
library("dplyr")
library("ggplot2")
library("gridExtra")
library("visdat")

aggr(newdata, numbers = TRUE, prop = c(TRUE, FALSE))

vis_dat(newdata)
vis_miss(newdata)
library(tidyr)
library(dplyr)
rename(no_data, NA)

#rename no_data to NA so that it will work with vis_dat
newdata[newdata$SEX =="no_data", "newdata"] <- "NA"
