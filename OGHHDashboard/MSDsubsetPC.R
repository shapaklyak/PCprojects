#Date updated: 7/11/2018
#Analyst: Katya Noykhovich
#Purpose: To combine FY15-16 with FY17-18 OU X IM MSD for OGHH dashboard
#Software: R

memory.limit(size = 90000)

getwd()
library(tidyverse)
library(dplyr)
library(plyr)

#import dataset, edit file name/location as needed
data <- readr::read_tsv("MER_Structured_Dataset_OU_IM_FY17-18_20180622_v2_1.txt", col_names = TRUE)
data2 <- readr::read_tsv("ICPI_MER_Structured_Dataset_OU_IM_FY15-16_20180515_v1_1.txt", col_names = TRUE)

#subset data for indicators of interest
d1sub <- subset(data, indicator == 'OVC_SERV' | indicator == 'PP_PREV')
d2sub <- subset(data2, indicator == 'OVC_SERV' | indicator == 'PP_PREV')

#check columns and column #s
names(d1sub)
names(d2sub)

#drop any unnecessary columns 
d1short <- d1sub[c(-(1:2),-(4), -(6), -(20), -(22), -(25:26), -(28), -(30), -(34))]
names(d1short)

d2short <- d2sub[c(-(1:2),-(4), -(6), -(11), -(17), -(22), -(24), -(27:28), -(30), -(34), -(36))]
names(d2short)

#reshape datasets from wide to long, putting all results/targets into one column; removes rows with missing values
longd2 <- gather(d2short, key= "period", "value", FY2015Q2:FY2016APR, na.rm=TRUE)
longd1 <- gather(d1short, key= "period", "value", FY2017_TARGETS:FY2019_TARGETS, na.rm=TRUE)

#Check # of columns match
ncol(longd1)
ncol(longd2)

names(longd1)
names(longd2)

#merge longdf1 and longdf2
mergedf <- rbind(longd1, longd2)

#subset data without NULL values
mergedf2 <- select(filter(mergedf, value != "NULL"),c(OperatingUnit:value))

str(mergedf2)

#subset for Funding Agency for Peace Corps only
finaldf <- subset(mergedf2, mergedf2$FundingAgency == "PC")

#Export dataset to csv or txt or xls for reading into Tableau
write.csv(finaldf,"MSDmergedFY15toFY18PC.csv", row.names = FALSE)
