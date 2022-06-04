library("ggplot2") 
library(data.table)
library(dplyr)
library(tidyr)




data_100 <- read.csv("data/data (100 years).csv", header = TRUE)



# extracting data we need
# getting mean
data_100_mini_table <- aggregate(x = data_100$MQ,     
                                      
                                      by = list(data_100$Station),      
                                      
                                      FUN = mean)

colnames(data_100_mini_table) <- c("Station", "MQ")


# getting maximum runoff
data_100_mini_table$HQ <- aggregate(x = data_100$HQ,     
                                 
                                 by = list(data_100$Station),      
                                 
                                 FUN = mean)$x


# getting minimum
data_100_mini_table$LQ <- aggregate(x = data_100$LQ,     
                                    
                                    by = list(data_100$Station),      
                                    
                                    FUN = mean)$x


#getting altitude by station

data_100_mini_table$Alt <- aggregate(x = data_100$Alt,     
                                    
                                    by = list(data_100$Station),      
                                    
                                    FUN = unique)$x

#getting catchment size by station
data_100_mini_table$Catchment.size <- aggregate(x = data_100$Catchment.size,     
                                     
                                     by = list(data_100$Station),      
                                     
                                     FUN = unique)$x

#getting summer mean by station
data_100_mini_table$Summer.mean <- aggregate(x = data_100$Summer.mean,     
                                     
                                     by = list(data_100$Station),      
                                     
                                     FUN = mean)$x

#getting winter mean by station
data_100_mini_table$Winter.mean <- aggregate(x = data_100$Winter.mean,     
                                             
                                             by = list(data_100$Station),      
                                             
                                             FUN = mean)$x

#getting continent by station
data_100_mini_table$Continent <- aggregate(x = data_100$Continent,     
                                                
                                                by = list(data_100$Station),      
                                                
                                                FUN = unique)$x
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
data_100_mini_table$HQ <- round(data_100_mini_table$HQ, 2)
data_100_mini_table$LQ <- round(data_100_mini_table$LQ, 2)
data_100_mini_table$Summer.mean <- round(data_100_mini_table$Summer.mean, 2)
data_100_mini_table$Winter.mean <- round(data_100_mini_table$Winter.mean, 2)




# select only the most representative data

# JPEG DOES NOT WORK INSIDE OF THE FUNCTION AND DOES NOT THROW AN ERROR.
bar_plot_representation <- function(mini_df){
  
  
  # constructing bar plots
  
  x_names = c("MQ", "HQ", "LQ", "Alt", "Catchment size", "Summer mean", "Winter mean")
  
  values = c(mini_df$MQ, mini_df$HQ, mini_df$LQ, mini_df$Alt, mini_df$Catchment.size, mini_df$Summer.mean, mini_df$Winter.mean)
  
  
  df_tidy <- data.frame(x_names,values)
  
  
  # No  y limit
  ggplot(df_tidy, aes(x=x_names, y=values, fill=x_names)) + 
    geom_bar(stat='identity') + 
    xlab("Types") +
    ylab("Value")
  
  
}
bar_plot_representation_y_lim <- function(mini_df, y_lim_start= 0, y_lim_end = 50000){
  
  
  # constructing bar plots
  
  x_names = c("MQ", "HQ", "LQ", "Alt", "Catchment size", "Summer mean", "Winter mean")
  
  values = c(mini_df$MQ, mini_df$HQ, mini_df$LQ, mini_df$Alt, mini_df$Catchment.size, mini_df$Summer.mean, mini_df$Winter.mean)
  
  
  df_tidy <- data.frame(x_names,values)

  # No  y limit
  ggplot(df_tidy, aes(x=x_names, y=values, fill=x_names)) + 
    geom_bar(stat='identity') + 
    xlab("Types") +
    ylab("Value")

  # with y limit
  ggplot(df_tidy, aes(x=x_names, y=values, fill=x_names)) + 
    geom_bar(stat='identity') +
    coord_cartesian(ylim = c(y_lim_start, y_lim_end)) + 
    xlab("Types") +
    ylab("Value")
  
  
}





# highest mean
file_name <- "highest mean"

jpeg(paste0("data/", file_name, ".jpeg"), quality = 100)
bar_plot_representation(data_100_mini_table[which.max(data_100_mini_table$MQ), ])
dev.off()

jpeg(paste0("data/", file_name, " y limit.jpeg"), quality = 100)
bar_plot_representation_y_lim(data_100_mini_table[which.max(data_100_mini_table$MQ), ], y_lim_end = 40000)
dev.off()


# lowest mean
file_name <- "lowest mean"
jpeg(paste0("data/", file_name, ".jpeg"), quality = 100)
bar_plot_representation(data_100_mini_table[which.min(data_100_mini_table$MQ), ])
dev.off()
jpeg(paste0("data/", file_name, " y limit.jpeg"), quality = 100)
bar_plot_representation_y_lim(data_100_mini_table[which.min(data_100_mini_table$MQ), ], y_lim_end = 100)
dev.off()


# highest altitude
file_name <- "highest altitude"
jpeg(paste0("data/", file_name, ".jpeg"), quality = 100)
bar_plot_representation(data_100_mini_table[which.max(data_100_mini_table$Alt), ])
dev.off()

jpeg(paste0("data/", file_name, " y limit.jpeg"), quality = 100)
bar_plot_representation_y_lim(data_100_mini_table[which.max(data_100_mini_table$Alt), ], y_lim_end = 3500)
dev.off()


# lowest altitude
file_name <- "lowest altitude"

jpeg(paste0("data/", file_name, ".jpeg"), quality = 100)
bar_plot_representation(data_100_mini_table[which.min(data_100_mini_table$Alt), ])
dev.off()
jpeg(paste0("data/", file_name, " y limit.jpeg"), quality = 100)
bar_plot_representation_y_lim(data_100_mini_table[which.min(data_100_mini_table$Alt), ], y_lim_end = 10000)
dev.off()



# highest catchment size
file_name <- "highest catchment size"
jpeg(paste0("data/", file_name, ".jpeg"), quality = 100)
bar_plot_representation(data_100_mini_table[which.max(data_100_mini_table$Catchment.size), ])
dev.off()
jpeg(paste0("data/", file_name, " y limit.jpeg"), quality = 100)
bar_plot_representation_y_lim(data_100_mini_table[which.max(data_100_mini_table$Catchment.size), ], y_lim_end = 40000)
dev.off()

# lowest catchment size
file_name <- "lowest catchment size"
jpeg(paste0("data/", file_name, ".jpeg"), quality = 100)
bar_plot_representation(data_100_mini_table[which.min(data_100_mini_table$Catchment.size), ])
dev.off()
jpeg(paste0("data/", file_name, " y limit.jpeg"), quality = 100)
bar_plot_representation_y_lim(data_100_mini_table[which.min(data_100_mini_table$Catchment.size), ], y_lim_end = 100)
dev.off()


# highest difference between catchment size and altitude
data <- abs(data_100_mini_table$Catchment.size - data_100_mini_table$Alt)
file_name <- "highest difference between catchment size and altitude"

jpeg(paste0("data/", file_name, ".jpeg"), quality = 100)
bar_plot_representation(data_100_mini_table[which.max(data), ])
dev.off()
jpeg(paste0("data/", file_name, " y limit.jpeg"), quality = 100)
bar_plot_representation_y_lim(data_100_mini_table[which.max(data), ], y_lim_end = 40000)
dev.off()

# lowest difference between  catchment size and altitude
file_name <-  "lowest difference between  catchment size and altitude"

jpeg(paste0("data/", file_name, ".jpeg"), quality = 100)
bar_plot_representation(data_100_mini_table[which.min(data), ])
dev.off()

jpeg(paste0("data/", file_name, " y limit.jpeg"), quality = 100)
bar_plot_representation_y_lim(data_100_mini_table[which.min(data), ], y_lim_end = 1000)
dev.off()



# which max/min by continent


# max by continent
data_100_mini_table_max <- data_100_mini_table %>%
  group_by(Continent) %>%
  slice(which.max(MQ))

data_100_mini_table_max_tidy <- gather(data_100_mini_table_max, types, Value, c(MQ, Alt, Catchment.size))

jpeg("data/max MQ by continent.jpeg", quality = 100)
ggplot(data_100_mini_table_max_tidy, aes(x = data_100_mini_table_max_tidy$types, y = data_100_mini_table_max_tidy$Value, fill = Continent)) + geom_bar(stat = "identity", position = "dodge") + 
  xlab("Types") +
  ylab("Value")
dev.off()
jpeg("data/max MQ by continent zoom 1.jpeg", quality = 100)
#zoom
ggplot(data_100_mini_table_max_tidy, aes(x = data_100_mini_table_max_tidy$types, y = data_100_mini_table_max_tidy$Value, fill = Continent)) + geom_bar(stat = "identity", position = "dodge") +
  coord_cartesian(ylim = c(0, 20000)) + 
  xlab("Types") +
  ylab("Value")
dev.off()

jpeg("data/max MQ by continent zoom 2.jpeg", quality = 100)
# zoom
ggplot(data_100_mini_table_max_tidy, aes(x = data_100_mini_table_max_tidy$types, y = data_100_mini_table_max_tidy$Value, fill = Continent)) + geom_bar(stat = "identity", position = "dodge") +
  coord_cartesian(ylim = c(0, 500)) + 
  xlab("Types") +
  ylab("Value")

dev.off()


# min by continent
data_100_mini_table_min <- data_100_mini_table %>%
  group_by(Continent) %>%
  slice(which.min(MQ))


data_100_mini_table_min_tidy <- gather(data_100_mini_table_min, types, Value, c(MQ, Alt, Catchment.size))



jpeg("data/min MQ by continent.jpeg", quality = 100)
ggplot(data_100_mini_table_min_tidy, aes(x = data_100_mini_table_min_tidy$types, y = data_100_mini_table_min_tidy$Value, fill = Continent)) + geom_bar(stat = "identity", position = "dodge") + 
  xlab("Types") +
  ylab("Value")
dev.off()

jpeg("data/min MQ by continent zoom 1.jpeg", quality = 100)
#zoom
ggplot(data_100_mini_table_min_tidy, aes(x = data_100_mini_table_min_tidy$types, y = data_100_mini_table_min_tidy$Value, fill = Continent)) + geom_bar(stat = "identity", position = "dodge") +
  coord_cartesian(ylim = c(0, 7500)) + 
  xlab("Types") +
  ylab("Value")

dev.off()

jpeg("data/min MQ by continent zoom 2.jpeg", quality = 100)
# zoom
ggplot(data_100_mini_table_min_tidy, aes(x = data_100_mini_table_min_tidy$types, y = data_100_mini_table_min_tidy$Value, fill = Continent)) + geom_bar(stat = "identity", position = "dodge") +
  coord_cartesian(ylim = c(0, 3000)) + 
  xlab("Types") +
  ylab("Value")

dev.off()


jpeg("data/min MQ by continent zoom 3.jpeg", quality = 100)
# zoom
ggplot(data_100_mini_table_min_tidy, aes(x = data_100_mini_table_min_tidy$types, y = data_100_mini_table_min_tidy$Value, fill = Continent)) + geom_bar(stat = "identity", position = "dodge") +
  coord_cartesian(ylim = c(0, 100)) + 
  xlab("Types") +
  ylab("Value")
dev.off()





