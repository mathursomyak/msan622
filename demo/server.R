library(ggplot2)
data(movies)

getDataShapedUp <- function(){
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
  
  return(movies1)
}

makePlot <- function(DATASET, ALPHA){
  plot <- ggplot(data=DATASET, aes(x=budget,y=rating,color=as.factor(mpaa))) +
    geom_point(alpha = ALPHA)
  return(plot)
}

sendToGrey <- function(DATASET, GENRE_SELECTED){
  highlight[which(count == 1 & DATASET$GENRE_SELECTED == 1)] = T
  hi
}

shinyServer(function(input,output){
  
  output$scatterPlot <- renderPlot({
    mov <- getDataShapedUp()
    show(makePlot(mov,0.5))
  })
})

