require(rCharts)
require(shiny)
require(ggplot2)
mymovies <-read.csv("movies22.csv") # Has caldate
BoxPlots <-read.csv("BoxPlots.csv")
shinyServer(function(input, output) {
    
    output$boxplots <- renderPlot({
        
        p<-ggplot()+
            geom_point(data=mymovies, aes(x=ProductionBudget,y=DomesticBoxOfficeToDate))
        #p<- p + geom_boxplot(aes(x=Genre,y=ProductionBudget))
        
        print(p)
    })
})