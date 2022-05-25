# This program demonstartes the mean, global value of river runoff over a time
library("ggplot2") 


# setwd("data")


# read csv table
data_1961_1990 <- read.csv("data (1961 - 1990).csv", header = TRUE)
data_1991_2020 <- read.csv("data (1991 - 2020).csv", header = TRUE)


data_1961_2020 <- read.csv("data (1961 - 2020).csv", header = TRUE)


data_1961_2020_mean <- aggregate(x = data_1961_2020$HQ,     
          
          by = list(data_1961_2020$Year),      
          
          FUN = mean)

colnames(data_1961_2020_mean) <- c("Year", "HQ")

data_1961_2020_temporary <- aggregate(x = data_1961_2020$MQ,     
          
          by = list(data_1961_2020$Year),      
          
          FUN = mean)
colnames(data_1961_2020_temporary) <- c("Year", "MQ")

data_1961_2020_mean$MQ <- data_1961_2020_temporary$MQ


data_1961_2020_temporary <- aggregate(x = data_1961_2020$LQ,     
          
          by = list(data_1961_2020$Year),      
          
          FUN = mean)
colnames(data_1961_2020_temporary) <- c("Year", "LQ")
data_1961_2020_mean$LQ <- data_1961_2020_temporary$LQ


data_1961_2020_mean <- data_1961_2020_mean[!(data_1961_2020_mean$Year < 1961),]


jpeg("1961-2020.jpeg", quality = 100)

ggplot(data_1961_2020_mean) +  
  geom_smooth(aes(x = Year, y = HQ), method = "loess", color = "red") +
  geom_smooth(aes(x = Year, y = MQ), method = "loess", color = "green") +
  geom_smooth(aes(x = Year, y = LQ), method = "loess", color = "blue") +
  geom_vline(xintercept=1990, color = "red", size = 2) + 
  xlab("Year") +
  ylab("Runoff")
  
dev.off()

# aggregate(data_1961_2020$LQ, by = list(data_1961_2020$Year), FUN=mean(), na.action) 