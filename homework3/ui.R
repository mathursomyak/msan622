library(shiny)

shinyUI(fluidPage(
  
  titlePanel("US Illiteracy by Income"),
  
  sidebarLayout(
    
    sidebarPanel(
      h3("More Details"),
      checkboxInput(
        inputId= 'stateNames', 
        label = 'Show State Names',
        value=FALSE
        ),
       
      h3("Filter Regions"),
      checkboxGroupInput(
        "Regions",
        "",
        c("Northeast","South","West","North Central"),
        selected = c("Northeast","South","West","North Central")
        ),
      
      h3("Zoom In"),
      sliderInput(
        "x_lims", 
        "", min = 30000, max = 67000, 
        value = c(30000,67000)
        ),
      
      h3("Bubble Size"),
      radioButtons(
        "bub_size", 
        "", 
        choices = c(
          "Population" = "Population",
          "State Area" = "Area",
          "Population Density" = "PopDensity"),
        selected = "Population"
        ),
      div(),
      h6("_______________________"),
      h6("Income: per capita 1974"),
      h6("Illiteracy: percentage of pop 1970"),
      width = 2
      ),
    
      mainPanel(
        tabsetPanel(
          tabPanel("Bubble Plot", plotOutput("bubblePlot",height = "600px")), 
          tabPanel("Small Multiples", plotOutput("smaMult", height = "600px")),
          tabPanel("Parallel Coordinates", plotOutput("PCoord"))
        ),
        width = 10
      )
    )
  )
)