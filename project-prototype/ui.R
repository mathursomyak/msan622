library(shiny)
library(shiny)
library(ggplot2)

dataset <- diamonds
movies <- read.csv("movies1.csv")

# fluidRow(
#     column(6,
#            h1("Movies Released 2008 - 2012"),
#            br(),
#            selectInput('popGroup', 'Groups', c("Oscar","Blockbuster"), names(dataset)[[2]])
#     )
    
shinyUI(navbarPage("Movies",
                   tabPanel("Density Plot"),
                   tabPanel("Component 2"),
                   tabPanel("Movie Seasons",
                       fluidPage(
                           fluidRow(
                               column(2,
                                      h1("Movies Released 2008 - 2012"),
                                      br(),
                                      selectInput('popGroup', 'Groups', c("Oscar","Blockbuster"))
                                      ),
                               column(10,
                                      plotOutput("plotty",height="700px")
                                      )
                               ))
                    )
))