library(ggplot2)

artdata <- read.csv("myDatbyArt.csv")
artdata$urbanOrigin <- artdata$term %in%
    c('hip hop',
      'jazz',
      'r&b',
      'rap',
      'reggae',
      'soul')
artdata$contemporary <- artdata$term %in%
    c('electronic',
      'hip hop',
      'house',
      'indie',
      'pop',
      'pop rock',
      'rap',
      'rock',
      'techno')
artdata$guitarBased <- artdata$term %in%
    c('acoustic',
      'alternative',
      'folk',
      'indie',
      'instrumental',
      'metal',
      'punk',
      'rock')

shinyServer(function(input, output) {
    colorsSplit <- reactive({input$splitter})
    
    output$Plotty <- renderPlot({ 

        colorS <- colorsSplit()
        #browser()
        p <- ggplot(data=artdata) + 
            geom_point(aes_string
                       (x="artist_hotttnesss",
                        y="artist_familiarity",
                        size=5,
                        color=colorS,
                        na.rm=T,
                        alpha= 0.5)
                       )
        print(p)
        
    })
    
}
)