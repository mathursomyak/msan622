library(ggplot2)
data(movies)

# MOVIES DATA TRANSFORM #
#========================
getDataShapedUp <- function(){
  data(movies)
  movies1 <- subset(movies,budget>0) #filter out movies with a negative budget
  movies1 <- subset(movies1,(mpaa)!='') #filter out movies without an mpaa rating
  
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
  movies1$mpaa <- factor(movies1$mpaa, levels = c("NC-17","R","PG-13","PG"))
  return(movies1)
}

# VISUALIZATION #
#================
movies1 <- getDataShapedUp()
ggplot(data=movies1, aes(x=budget,
                         y=rating,
                         color=as.factor(mpaa)                        
                         )) +
  geom_point(alpha = 0.5, size = 8) +
  #ggtitle("title")+
  theme(panel.grid.major.x = element_blank()) +
  theme(panel.grid.minor.y = element_blank()) +
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_text(size = 12),
        panel.background = element_blank(),
        legend.position = "bottom")+
  labs(color = "MPAA Rating")+
  scale_color_brewer(palette = "Dark2")


