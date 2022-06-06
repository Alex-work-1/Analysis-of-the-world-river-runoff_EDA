install.packages(plotly)
library(plotly)


data_1961_1990 <- read.csv("data/data (1961 - 1990).csv", header = TRUE)



# extracting data we need
# getting mean
data_1961_1990_mini_table <- aggregate(x = data_1961_1990$MQ,     
                                 
                                 by = list(data_1961_1990$Station),      
                                 
                                 FUN = mean)

colnames(data_1961_1990_mini_table) <- c("Station", "MQ")

#getting longitude by station
data_1961_1990_mini_table$Lon <- aggregate(x = data_1961_1990$Lon,     
                                     
                                     by = list(data_1961_1990$Station),      
                                     
                                     FUN = unique)$x
#getting latitude by station
data_1961_1990_mini_table$Lat <- aggregate(x = data_1961_1990$Lat,     
                                     
                                     by = list(data_1961_1990$Station),      
                                     
                                     FUN = unique)$x

# round values
data_1961_1990_mini_table$MQ <- round(data_1961_1990_mini_table$MQ, 2)




jpeg("data/Map 1961-1990 of years.jpeg", quality = 100)
plot_ly(x = data_1961_1990_mini_table$Lon, y = data_1961_1990_mini_table$Lat, z = data_1961_1990_mini_table$MQ, type="scattergeo", mode = "markers", color = data_1961_1990_mini_table$MQ) 
dev.off()
