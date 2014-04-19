#ui.R

library(shiny)

shinyUI(fluidPage(
    
    h1("Alice in Wonderland"),
    h4("Character Mentions by Chapter"),
    h1("___________"),
    
    sidebarLayout(
        
        sidebarPanel(
            h3("Chapter Progression"),
            sliderInput("chapter", "", min = 1, max = 12, value = 1, animate=TRUE ),
            width = 2
            ),
        mainPanel(plotOutput("charbar",height="600px"),width=10)
        )
    )
)