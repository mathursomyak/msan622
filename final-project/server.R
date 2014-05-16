library(ggplot2)
library(plyr)
library(grid)


# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
    mymovies <- read.csv("movies3.csv") # Has caldate
    
    #MOVIE SEASONS - PLOT 1
    output$plotty <- renderPlot({
        
        # Create the Plot
      p <-ggplot(mymovies, aes_string(x = "CalDate", fill=input$popGroup)) +
            geom_density(alpha=.3) +
            # Month labels for x axis
            scale_x_discrete(breaks=c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"),
                             labels=c("J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"),
                             expand=c(0,0)) +
            
            # Axes Titles
            labs( x = "Movie Release Date (In US)",
                  y = "",
                  fill = input$popGroup) +
            
            # Theme
            theme( axis.ticks.y = element_blank()
                   ,axis.text.y  = element_blank()
                   ,axis.text.x  = element_text(size=17)
                   ,axis.title.x = element_text(size=20)
                   
                   ,legend.justification = c(0,1)
                   ,legend.position = c(0,1)
                   #,legend.background = element_rect(size=15)
                   ,legend.key.size = unit(1,"cm")
                   ,legend.title = element_text(size=17)
                   ,legend.text = element_text (size=17)
            )
            print(p)
    })
    #OVERRATED MOVIES - PLOT 2
    #NVD3
    output$overrated <- renderChart({
        p1 <- nPlot(RottenTomatosAudienceScore ~ RottenTomatosCriticsScore,
                    group = 'BigGenre', 
                    data = mymovies, 
                    type = 'scatterChart'
        )
        p1$xAxis(axisLabel = 'Critics Score')
        p1$yAxis(axisLabel = 'Audience Score')
        p1$chart(tooltipContent = "#! function(key, x, y, e){ 
            return e.point.Movie + ' ('+e.point.Year+')'
            } !#")
        p1$addParams(dom = 'overrated')
        return(p1)
    })
})

