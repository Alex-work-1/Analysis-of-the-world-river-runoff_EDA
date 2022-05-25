# This program demonstartes the mean, global value of river runoff over a time


#data_working_dir <- paste0(dirname(getwd()), "/data") #--if working dir is "EDA work/code", then use this
# setwd("data")


# read csv table
grdc_selection <- read.csv("grdc_selection.csv", header = TRUE)



# getting rid of NAs in LQ, MQ and HQ columns and replacing it with the mean value of the station of all the time

grdc_selection[, "LQ"][is.na(grdc_selection[,"LQ"])] <- mean(grdc_selection$LQ, by = grdc_selection$ID, 
                                                  na.rm = TRUE)

grdc_selection[, "MQ"][is.na(grdc_selection[,"MQ"])] <- mean(grdc_selection$MQ, by = grdc_selection$ID, 
                                                             na.rm = TRUE)

grdc_selection[, "HQ"][is.na(grdc_selection[,"HQ"])] <- mean(grdc_selection$HQ, by = grdc_selection$ID, 
                                                             na.rm = TRUE)



# getting the common minimum and maximum year of stations data
# getting the COMMON minimum
dt_start <- grdc_selection[!duplicated(grdc_selection[c('River')]), ]
max(dt_start$Year)

# getting the COMMON maximum
dt_end <- grdc_selection[!duplicated(grdc_selection[c('River')], fromLast = TRUE), ]
min(dt_end$Year)


# We have got the unbroken period of collected data -- 1935-1972 year
# As our task is to analyse period between 1961 - 2020, we have to filter all stations & years which doesn't suits this period, in order to not get big rises or falling on graph because of getting/loosing data of additional stations. We need a continuous data.


# filtering years/stations which is not in the year range 1961 - 2020.
grdc_selection[grdc_selection$Year >= 1961 && grdc_selection$Year <= 2020]

dt_end

# aggregate(grdc_selection$LQ, by = list(grdc_selection$Year), FUN=mean(), na.action) 