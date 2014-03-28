#install.packages("Rtools")
#install.packages("ggplot2")
#find_rtools(T)
library(devtools)
library (ggplot2)

# MOVIES DATA #
#==============
data (movies)
movies1 <- subset(movies,budget>0) #filter out movies with a negative budget
#View(movies1)
genre <- rep(NA, nrow(movies1))
count <- rowSums(movies1[, 18:24])
genre[which(count > 1)] = "Mixed"
genre[which(count < 1)] = "None"
genre[which(count == 1 & movies1$Action == 1)] = "Action"
genre[which(count == 1 & movies1$Animation == 1)] = "Animation"
genre[which(count == 1 & movies1$Comedy == 1)] = "Comedy"
genre[which(count == 1 & movies1$Drama == 1)] = "Drama"
genre[which(count == 1 & movies1$Documentary == 1)] = "Documentary"
genre[which(count == 1 & movies1$Romance == 1)] = "Romance"
genre[which(count == 1 & movies1$Short == 1)] = "Short"
 
movies1$genre <- genre
# STOCKS DATA #
#===============
data(EuStockMarkets)
eu <- transform(data.frame(EuStockMarkets), time = time(EuStockMarkets))

# PLOT 1 #
#==============
#Scatterplot.** Produce a scatterplot from the `movies` dataset in the `ggplot2` package, 
#where `budget` is shown on the x-axis and `rating` is shown on the y-axis. Save the plot as `hw1-scatter.png`.
hw1.scatter <- 
  ggplot(movies1, aes(x=budget, y=rating, color=budget))+
  geom_point()+
  coord_trans(x="log2")+
  ggtitle("Scatter Plot\nRatings by Budget")+
  xlab("Budget: log scale")+
  theme(plot.title = element_text(face="bold"))
ggsave(filename = "hw1-scatter.png", plot = hw1.scatter)


# PLOT 2 #
#==============
#Bar Chart.** Count the number of action, adventure, etc. movies in the `genre` column of the `movies` dataset. 
#Show the results as a bar chart, and save the chart as `hw1-bar.png`.

g<- as.data.frame(sort(table(genre))) #sorted orders of bars by height
View(g)
hw1.bar <-
  ggplot(data=movies1, aes(x=genre))+
  geom_bar()+
  theme(axis.text.x = element_text(angle=-30,size=14,hjust=-.05))+
  xlab("")+
  ggtitle("Movies by Genre") + theme(plot.title = element_text(face="bold", size = 14))+
  scale_x_discrete(limits=c(rownames(g))) #sorts the bars by height
ggsave(filename = "hw1-bar.png", plot = hw1.bar)

# PLOT 3 #
#==============
#**Plot 3: Small Multiples.** Use the `genre` column in the `movies` dataset to generate a small-multiples 
#scatterplot using the `facet_wrap()` function such that `budget` is shown on the x-axis and `rating` is shown 
#on the y-axis. Save the plot as `hw1-multiples.png`.
hw1.multiples <-
  ggplot(data = movies1, aes(x=budget,y=rating))+
  geom_point()+
  facet_wrap(~ genre)+
  theme(axis.text.x = element_text(angle=-30,hjust=-.05))+
  geom_line(stat = "hline",yintercept = "mean", color = "red")+
  #annotate("segment")
  ggtitle("Does a big budget mean high ratings?")+
  theme(plot.title = element_text(face="bold", size = 14))+
  xlab("budget (red line is the genre mean)")
ggsave(filename = "hw1-multiples.png", plot = hw1.multiples)


# PLOT 4 #
#==============
#Multi-Line Chart.** Produce a multi-line chart from the `eu` dataset 
#(created by transforming the `EuStockMarkets` dataset) with `time` shown on the x-axis and `price` on the
#y-axis. Draw one line for each index on the same chart. Save the plot as `hw1-multiline.png`.
#View(eu)
hw1.multiline <-
  ggplot(data = eu, aes(x=time))+
  geom_line(aes(y=DAX,color="DAX"))+
  geom_line(aes(y=CAC,color="CAC"))+
  geom_line(aes(y=SMI,color="SMI"))+
  geom_line(aes(y=FTSE,color="FTSE"))+
  ggtitle("Financial Indecies Trends")+
  theme(plot.title = element_text(face="bold", size = 14))+
  scale_color_discrete("Financial\nIndex")+
  ylab("price")
ggsave(filename = "hw1-multiline.png", plot = hw1.multiline)
