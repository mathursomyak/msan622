library(shiny)
library(ggplot2)

#Function to load data and shape it up
getDataShapedUp <- function(){
  data("movies", package = "ggplot2")
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

movies1 <- getDataShapedUp()

#Function to make a plot
getPlot <- function(localFrame, dotAlpha) {
  localPlot <- ggplot(data=movies1, aes(x=budget,y=rating,color=as.factor(mpaa))) +
    geom_point(alpha = dotAlpha ,position="jitter")
  return(localPlot)
}

#GLOBAL OBJECTS
globalData <- getDataShapedUp()

shinyServer(function(input, output) {
  localFrame <- globalData
  output$scatterPlot <- renderPlot({
    plotty <- getPlot(localFrame,input$alpha)
    return(plotty)})
})

runApp()

