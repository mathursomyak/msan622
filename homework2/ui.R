library(shiny)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Hello Shiny!"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    sliderInput("alpha", 
                "Alpha:", 
                min = .1,
                max = 1, 
                value = .5)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("scatterPlot")
  )
))