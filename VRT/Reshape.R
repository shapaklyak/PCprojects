#Date updated: 7/20/2018
#Analyst: Katya 
#Purpose: To reshape VRT Results (Combined indicator report) wide to long
#Software: R

getwd()
library(tidyverse)
library(dplyr)
library(plyr)

#import dataset, edit file name/location as needed
HE183 <- readr::read_tsv("FY17HE183.txt", col_names = TRUE)

#reshape datasets from wide to long, putting all results/targets into one column; removes rows with missing values
longHE183 <- gather(HE183, key= "disagg", "result", 6:15, na.rm=TRUE)

#Export dataset to csv or txt or xls for reading into Tableau
write.csv(longHE183,"FY17_HE183ALLposts.csv", row.names = FALSE)



##REPEAT FOR HE-184
#import dataset, edit file name/location as needed
HE184 <- readr::read_tsv("FY17HE184.txt", col_names = TRUE)

#reshape datasets from wide to long, putting all results/targets into one column; removes rows with missing values
longHE184 <- gather(HE184, key= "disagg", "result", 6:21, na.rm=TRUE)

#Export dataset to csv or txt or xls for reading into Tableau
write.csv(longHE184,"FY17_HE184ALLposts.csv", row.names = FALSE)
