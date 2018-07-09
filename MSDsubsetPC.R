#Date updated: 7/09/2018
#Analyst: Katya Noykhovich
#Purpose: To subset OU X IM MSD for OGHH dashboard
#Software: R
  
memory.limit(size = 90000)

getwd()
library(tidyverse)
library(dplyr)

#import dataset, edit file name/location as needed
data <- readr::read_tsv("filename.txt", col_names = TRUE)

#subset for indicators of interest
sub1 <- subset(data, indicator == 'OVC_SERV' | indicator == 'PP_PREV')

#subset for PC countries:
sub2 <- subset(sub1, sub1$FundingAgency == "PC")

names(sub2)

#drop any unnecessary columns 
sub3 <- sub2[c(-(1:2),-(4), -(6), -(22), -(25:26), -(28), -(30), -(34))]
names(sub3)

#export dataset to csv/txt for dashboard
write.csv(sub3,"OGHHdash_MSD_OUxIM_20180622.csv", row.names = FALSE)
