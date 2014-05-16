require(rCharts)
shinyUI(pageWithSidebar(
    headerPanel("MOVIES"),
    
    sidebarPanel(
        selectInput(inputId = "x",
                    label = "Choose X",
                    choices = c('SepalLength', 'SepalWidth', 'PetalLength', 'PetalWidth'),
                    selected = "SepalLength"),
        selectInput(inputId = "y",
                    label = "Choose Y",
                    choices = c('SepalLength', 'SepalWidth', 'PetalLength', 'PetalWidth'),
                    selected = "SepalWidth")
        
    ),
    mainPanel(
        #showOutput("myChart3", "NVD3"),
        #showOutput("myChart4", "polycharts"),
        plotOutput("boxplots")
        
    )
))