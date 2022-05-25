library(ggplot2)

setwd("data")


data_1961_2020 <- read.csv("data (1961 - 2020).csv", header = TRUE)

data_1961_2020_mean <- aggregate(x = data_1961_2020$MQ,     
                                 
                                 by = list(data_1961_2020$Year),      
                                 
                                 FUN = mean)

colnames(data_1961_2020_mean) <- c("Year", "MQ")

data_1961_2020_mean <- data_1961_2020_mean[!(data_1961_2020_mean$Year < 1961),]





model <- lm(MQ ~ Year, data = data_1961_2020_mean)




#====================
# VISUALIZE THE MODEL
#====================


model_intercept <- coef(model)[1]
model_slope <- coef(model)[2]

coef(model)

#-----
# PLOT
#-----
jpeg("1961-2020_linear_regression.jpeg", quality = 100)

ggplot(data = data_1961_2020_mean, aes(x = Year, y = MQ)) +
  geom_point() +
  geom_abline(intercept = model_intercept, slope = model_slope, color = 'red') +
  labs(title = "Linear regression model",
       subtitle = "the calculated formula: 3.474315 * year - -6288.017122",
       caption = "year 1961 - 2020")
  
dev.off()




