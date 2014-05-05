library(shiny)
shinyUI(fluidPage(
    titlePanel("title panel"),
    
    sidebarLayout(
        sidebarPanel( 
            radioButtons("splitter", "splitter",
                         c("Urban Origin" = "urbanOrigin",
                           "Contemporary" = "contemporary",
                           "Guitar-based" = "guitarBased")),
            width=2
            ),
        mainPanel(plotOutput("Plotty",height="600px"),width=10)
    )
))