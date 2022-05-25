install.packages("tidyverse")  
install.packages("scales")
install.packages("stringr")
install.packages("Hmisc") 
install.packages("forcats")
install.packages("ggthemes")
library(data.table)
library(ggplot2)
library("tidyverse") 
library("scales") 
library("stringr") 
library("Hmisc") 
library("forcats") 
library("ggthemes")
library(tidyverse)
library(tidyr)

setwd("data")

colset_4 <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")
theme_set(theme_bw())

data_100_years_ <- read.csv("data (100 years).csv", header = TRUE)

data_100_years_2 <- data.frame(data_100_years_)
data_100_years_2[1:16] <- NULL       #####Delete columns and only choosing Summer and Winter runoff means
view(data_100_years_2)
colnames(data_100_years_2)           #### Change column names
names(data_100_years_2)[names(data_100_years_2) == "Summer.mean"] <- "Summer"
names(data_100_years_2)[names(data_100_years_2) == "Winter.mean"] <- "Winter"
data_100_years_2
view(data_100_years_2)
#Tidy format
data_summerwintermean2 <- gather(data_100_years_2, Season, Runoff, Summer:Winter, factor_key=TRUE)
view(data_summerwintermean2)

jpeg("difference between summer and winter by continent 4.jpeg", quality = 100)


#Boxplot of the summer and winter means per station
ggplot(data_summerwintermean2, aes(x = Season, y = Runoff, fill=Season)) +            
  geom_boxplot(alpha=0.3) +
  xlab(label = "Season") +
  ylab(label = "Runoff (m3/s)") +
  theme_bw()

dev.off()

#Not representative because there are a lot of outliers and can't analize the plots 
#because it is difficult to tell if there are higher runoffs during the winter or summer
mean(data_100_years_2$Summer)
mean(data_100_years_2$Winter)


jpeg("difference between summer and winter by continent 3.jpeg", quality = 100)

#Bar plots instead with the mean of summer and winter all over the world
ggplot(data_summerwintermean2, aes(Season, Runoff)) +           # ggplot2 barplot with mean
  geom_bar(position = "dodge",
           stat = "summary",
           fun = "mean")

dev.off()

#Differences between runoffs among the continents
data_100_years_4 <- data.frame(data_100_years_)
data_100_years_4[1:5] <- NULL 
data_100_years_4[2:11] <- NULL 
names(data_100_years_4)[names(data_100_years_4) == "Summer.mean"] <- "Summer"
names(data_100_years_4)[names(data_100_years_4) == "Winter.mean"] <- "Winter"
data_summerwintermean4 <- gather(data_100_years_4, Season, Runoff, Summer:Winter, factor_key=TRUE)

jpeg("difference between summer and winter by continent 2.jpeg", quality = 100)



ggplot(data_summerwintermean4, aes(x = Season, y = Runoff, fill=Continent)) +            
  geom_boxplot(alpha=0.3) +
  xlab(label = "Season") +
  ylab(label = "Runoff (m3/s)") +
  theme_bw() ###Boxplots with the means of summer and winter but not representative because there are too many outliers


dev.off()


print(data_summerwintermean4)
print(is.factor(data_summerwintermean4$Continent))
data_summerwintermean4$Continent <- as.factor(data_summerwintermean4$Continent)
print(is.factor(data_summerwintermean4$Continent))


jpeg("difference between summer and winter by continent.jpeg", quality = 100)


ggplot(data_summerwintermean4, aes(fill=Continent, y=Runoff, x=Season)) + 
  geom_bar(position="dodge", stat="identity", fun = "mean")   ### Barplots of the different runoff in the continents

dev.off()
