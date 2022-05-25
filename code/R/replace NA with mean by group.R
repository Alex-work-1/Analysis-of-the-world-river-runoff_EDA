library(data.table)

setwd("data")


#Import data frames
# 1961-1990
data_1961_1990 <- read.csv("data (1961 - 1990).csv", header = TRUE)

#1991 - 2020
data_1991_2020 <- read.csv("data (1991 - 2020).csv", header = TRUE)

#1961 - 2020
data_1961_2020 <- read.csv("data (1961 - 2020).csv", header = TRUE)

#100 years
data_100_years <- read.csv("data (100 years).csv", header = TRUE)






#getting standart forms of NA
# 1961-1990
data_1961_1990[data_1961_1990 == -999] <- NA
data_1961_1990[data_1961_1990 == "nan"] <- NA
data_1961_1990[data_1961_1990 == "NaN"] <- NA


#1991 - 2020
data_1991_2020[data_1991_2020 == -999] <- NA
data_1991_2020[data_1991_2020 == "nan"] <- NA
data_1991_2020[data_1991_2020 == "NaN"] <- NA

#1961 - 2020
data_1961_2020[data_1961_2020 == -999] <- NA
data_1961_2020[data_1961_2020 == "nan"] <- NA
data_1961_2020[data_1961_2020 == "NaN"] <- NA

#100 years
data_100_years[data_100_years == -999] <- NA
data_100_years[data_100_years == "nan"] <- NA
data_100_years[data_100_years == "NaN"] <- NA





# CLEANING DATA
# remove rows where altitude or catchment size is NA

# 1961-1990
data_1961_1990 <- data_1961_1990[!is.na(data_1961_1990$Alt),]
data_1961_1990 <- data_1961_1990[!is.na(data_1961_1990$Catchment.size),]


#1991 - 2020
data_1991_2020 <- data_1991_2020[!is.na(data_1991_2020$Alt),]
data_1991_2020 <- data_1991_2020[!is.na(data_1991_2020$Catchment.size),]

#1961 - 2020
data_1961_2020 <- data_1961_2020[!is.na(data_1961_2020$Alt),]
data_1961_2020 <- data_1961_2020[!is.na(data_1961_2020$Catchment.size),]

#100 years
data_100_years <- data_100_years[!is.na(data_100_years$Alt),]
data_100_years <- data_100_years[!is.na(data_100_years$Catchment.size),]










#replacing NA with mean by group

# 1961-1990
data_1961_1990[, "LQ"][is.na(data_1961_1990[,"LQ"])] <- round(mean(data_1961_1990$LQ, by = data_1961_1990$Station, na.rm = TRUE), 2)

data_1961_1990[, "HQ"][is.na(data_1961_1990[,"HQ"])] <- round(mean(data_1961_1990$HQ, by = data_1961_1990$Station, na.rm = TRUE), 2)

data_1961_1990[, "MQ"][is.na(data_1961_1990[,"MQ"])] <- round(mean(data_1961_1990$MQ, by = data_1961_1990$Station, na.rm = TRUE), 2)

data_1961_1990[, "Summer.mean"][is.na(data_1961_1990[,"Summer.mean"])] <- round(mean(data_1961_1990$Summer.mean, by = data_1961_1990$Station, na.rm = TRUE), 2)

data_1961_1990[, "Winter.mean"][is.na(data_1961_1990[,"Winter.mean"])] <- round(mean(data_1961_1990$Winter.mean, by = data_1961_1990$Station, na.rm = TRUE), 2)







#1991 - 2020
data_1991_2020[, "LQ"][is.na(data_1991_2020[,"LQ"])] <- round(mean(data_1991_2020$LQ, by = data_1991_2020$Station, na.rm = TRUE), 2)

data_1991_2020[, "HQ"][is.na(data_1991_2020[,"HQ"])] <- round(mean(data_1991_2020$HQ, by = data_1991_2020$Station, na.rm = TRUE), 2)

data_1991_2020[, "MQ"][is.na(data_1991_2020[,"MQ"])] <- round(mean(data_1991_2020$MQ, by = data_1991_2020$Station, na.rm = TRUE), 2)

data_1991_2020[, "Summer.mean"][is.na(data_1991_2020[,"Summer.mean"])] <- round(mean(data_1991_2020$Summer.mean, by = data_1991_2020$Station, na.rm = TRUE), 2)

data_1991_2020[, "Winter.mean"][is.na(data_1991_2020[,"Winter.mean"])] <- round(mean(data_1991_2020$Winter.mean, by = data_1991_2020$Station, na.rm = TRUE), 2)



#1961 - 2020
data_1961_2020[, "LQ"][is.na(data_1961_2020[,"LQ"])] <- round(mean(data_1961_2020$LQ, by = data_1961_2020$Station, na.rm = TRUE), 2)

data_1961_2020[, "HQ"][is.na(data_1961_2020[,"HQ"])] <- round(mean(data_1961_2020$HQ, by = data_1961_2020$Station, na.rm = TRUE), 2)

data_1961_2020[, "MQ"][is.na(data_1961_2020[,"MQ"])] <- round(mean(data_1961_2020$MQ, by = data_1961_2020$Station, na.rm = TRUE), 2)

data_1961_2020[, "Summer.mean"][is.na(data_1961_2020[,"Summer.mean"])] <- round(mean(data_1961_2020$Summer.mean, by = data_1961_2020$Station, na.rm = TRUE), 2)

data_1961_2020[, "Winter.mean"][is.na(data_1961_2020[,"Winter.mean"])] <- round(mean(data_1961_2020$Winter.mean, by = data_1961_2020$Station, na.rm = TRUE), 2)



#100 years
data_100_years[, "LQ"][is.na(data_100_years[,"LQ"])] <- round(mean(data_100_years$LQ, by = data_100_years$Station, na.rm = TRUE), 2)

data_100_years[, "HQ"][is.na(data_100_years[,"HQ"])] <- round(mean(data_100_years$HQ, by = data_100_years$Station, na.rm = TRUE), 2)

data_100_years[, "MQ"][is.na(data_100_years[,"MQ"])] <- round(mean(data_100_years$MQ, by = data_100_years$Station, na.rm = TRUE), 2)

data_100_years[, "Summer.mean"][is.na(data_100_years[,"Summer.mean"])] <- round(mean(data_100_years$Summer.mean, by = data_100_years$Station, na.rm = TRUE), 2)

data_100_years[, "Winter.mean"][is.na(data_100_years[,"Winter.mean"])] <- round(mean(data_100_years$Winter.mean, by = data_100_years$Station, na.rm = TRUE), 2)




# Updating csv file
# 1961-1990
write.csv(data_1961_1990, file = "data (1961 - 1990).csv")

#1991 - 2020
write.csv(data_1991_2020, file = "data (1991 - 2020).csv")
#1961 - 2020
write.csv(data_1961_2020, file = "data (1961 - 2020).csv")
#100 years
write.csv(data_100_years, file = "data (100 years).csv")

