library(ggplot2)
library(shiny)

AiW <- read.csv("AliceTextbyCh.csv")


as.factor(AiW$Word)
as.factor(AiW$Chapter)

shinyServer(function(input,output){
    chapter_to_graph <- reactive({subset(AiW,Chapter==input$chapter)})
    
    output$charbar <- renderPlot({
        myData <- chapter_to_graph()
        p <- ggplot(data=myData,aes(x=Word,y=Count))+geom_bar(color="#5ab4ac",fill="#5ab4ac")
        
        p <- p+ scale_y_continuous(limits = c(0, 50),expand=c(0.02,0))
        
        p <- p+xlab("Character Name") + ylab("Mentions")
        
        p <- p+theme(axis.ticks     = element_blank(),
                     axis.title.x   = element_text(size = 25, vjust= -1),
                     axis.title.y   = element_blank(),
                     axis.text.x    = element_text(size = 25),
                     axis.text.y    = element_text(size = 20),
                     #panel.background   = element_blank(),
                     panel.grid.major.x = element_blank(),
                     panel.grid.minor.x = element_blank()
                     #panel.grid.major.y = element_line(size=3,color="grey")
                     )
        
        print(p)
    })
})