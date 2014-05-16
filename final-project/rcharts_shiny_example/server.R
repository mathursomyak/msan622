require(rCharts)
require(shiny)
mymovies <-read.csv("movies22.csv") # Has caldate
shinyServer(function(input, output) {

    #NVD3
    output$myChart3 <- renderChart({
        p1 <- nPlot(RottenTomatosAudienceScore ~ RottenTomatosCriticsScore,
                    group = 'Genre', 
                    data = mymovies, 
                    type = 'scatterChart'
                    )
        p1$xAxis(axisLabel = 'Critics Score')
        p1$yAxis(axisLabel = 'Audience Score')
        p1$chart(tooltipContent = "#! function(key, x, y, e){ 
            return e.point.Movie + ' ('+e.point.Year+')'
            } !#")
        p1$addParams(dom = 'myChart3')
        return(p1)
    })
   
})