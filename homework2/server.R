library(ggplot2)
library(shiny)
library(scales)
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
  movies1$mpaa <- factor(movies1$mpaa, levels = c("NC-17","R","PG-13","PG"))
  return(movies1)
}
movies1 <- getDataShapedUp()

colors <- function(PALETTE, MPAA){
  highlight <- MPAA
  pal <- brewer_pal(type = "qual", palette = PALETTE)(4)
  mpaas <- c("NC-17","R","PG-13","PG")
  paldf <- cbind(pal,mpaas)
  newColor <- paldf[,1]
  newColor[which(mpaas!=highlight)] = "#bdbdbd"
  return (newColor)
}

makePlot <- function(ALPHA, SIZE, PALETTE, MPAA){
  mypalette <- colors(PALETTE,MPAA)
  mypalette
  plot <- ggplot(data=movies1, aes(x=budget,y=rating,color=as.factor(mpaa))) +
    geom_point(alpha = ALPHA, size = SIZE) +
    theme(panel.grid.major.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          axis.ticks.x = element_blank(),
          axis.text.x = element_text(size = 12),
          panel.background = element_blank(),
          legend.position = "bottom")+
    labs(color = "MPAA Rating")+
    xlab("Budget")+
    scale_fill_manual(values = mypalette)
  return(plot)
}



shinyServer(function(input,output){
  
  output$scatterPlot <- renderPlot({
    mov <- getDataShapedUp()
    print(makePlot(mov,input$alpha,input$size, input$palette, input$mpaa))
  })
})


