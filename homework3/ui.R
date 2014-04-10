library(shiny)

shinyUI(fluidPage(
  
  titlePanel(h1("US Illiteracy by Income")),
  
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
        "", min = 3000, max = 6700, 
        value = c(3000,6000)
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
        )
      ),
    
      mainPanel(
        tabsetPanel(
          tabPanel("Bubble Plot", plotOutput("bubblePlot")), 
          tabPanel("Small Multiples", plotOutput("smaMult")) 
          #,tabPanel("Table", tableOutput("table"))
        )
      )
    )
  )
)