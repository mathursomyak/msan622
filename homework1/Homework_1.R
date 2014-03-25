#install.packages("Rtools")
#install.packages("ggplot2")
#find_rtools(T)
library(devtools)
library (ggplot2)

# MOVIES DATA #
#==============
data (movies)
movies1 <- subset(movies,budget>0) #filter out movies with a negative budget
#View(movies)
genre <- rep(NA, nrow(movies))
count <- rowSums(movies[, 18:24])
genre[which(count > 1)] = "Mixed"
genre[which(count < 1)] = "None"
genre[which(count == 1 & movies$Action == 1)] = "Action"
genre[which(count == 1 & movies$Animation == 1)] = "Animation"
genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
genre[which(count == 1 & movies$Drama == 1)] = "Drama"
genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
genre[which(count == 1 & movies$Romance == 1)] = "Romance"
genre[which(count == 1 & movies$Short == 1)] = "Short"

# STOCKS DATA #
#===============
data(EuStockMarkets)
eu <- transform(data.frame(EuStockMarkets), time = time(EuStockMarkets))

# PLOT 1 #
#==============
#Scatterplot.** Produce a scatterplot from the `movies` dataset in the `ggplot2` package, 
#where `budget` is shown on the x-axis and `rating` is shown on the y-axis. Save the plot as `hw1-scatter.png`.
hw1-scatter <- 
  ggplot(movies1, aes(x=budget, y=rating))+geom_point()


# PLOT 2 #
#==============
#Bar Chart.** Count the number of action, adventure, etc. movies in the `genre` column of the `movies` dataset. 
#Show the results as a bar chart, and save the chart as `hw1-bar.png`.
hw1-bar <-
  ggplot(movies1, aes(x= ,y=))

