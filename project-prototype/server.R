library(ggplot2)
library(plyr)
library(grid)


# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
    movies <- read.csv("movies1.csv") # Has caldate
    output$plotty <- renderPlot({
        
        # The Two New Fill Variables
        Oscar <- as.factor(ifelse(movies$Nominations > 0, " Nominated", " Not Nominated"))
        Blockbuster <- as.factor(ifelse(movies$DomesticBoxOfficeToDate > 100000000, " Over 100M", " Under 100M"))
        
        # Create the Plot
      p <-ggplot(movies, aes_string(x = "CalDate", fill=input$popGroup)) +
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
})