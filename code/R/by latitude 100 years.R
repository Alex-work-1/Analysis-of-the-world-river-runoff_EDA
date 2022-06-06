library("ggplot2") 
install.packages(plotly)
library(plotly)


data_100 <- read.csv("data/data (100 years).csv", header = TRUE)



# extracting data we need
# getting mean
data_100_mini_table <- aggregate(x = data_100$MQ,     
                                 
                                 by = list(data_100$Station),      
                                 
                                 FUN = mean)

colnames(data_100_mini_table) <- c("Station", "MQ")

#getting longitude by station
data_100_mini_table$Lon <- aggregate(x = data_100$Lon,     
                                     
                                     by = list(data_100$Station),      
                                     
                                     FUN = unique)$x
#getting latitude by station
data_100_mini_table$Lat <- aggregate(x = data_100$Lat,     
                                     
                                     by = list(data_100$Station),      
                                     
                                     FUN = unique)$x

# round values
data_100_mini_table$MQ <- round(data_100_mini_table$MQ, 2)






jpeg("data/Latitude - Runoff.jpeg", quality = 100)
ggplot(data = data_100_mini_table, aes(x = Lat, y = MQ)) +
  geom_line(color="red") +
  geom_point()
dev.off()

jpeg("data/Longitude - Runoff.jpeg", quality = 100)
ggplot(data = data_100_mini_table, aes(x = Lon, y = MQ)) +
  geom_line(color="red")+
  geom_point()
dev.off()


jpeg("data/Map 100 of years.jpeg", quality = 100)
plot_ly(x = data_100_mini_table$Lon, y = data_100_mini_table$Lat, z = data_100_mini_table$MQ, type="scattergeo", mode = "markers", color = data_100_mini_table$MQ) 
dev.off()
