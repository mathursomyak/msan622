library(shiny)
library(ggplot2)


#movies <- read.csv("movies3.csv")

# fluidRow(
#     column(6,
#            h1("Movies Released 2008 - 2012"),
#            br(),
#            selectInput('popGroup', 'Groups', c("Oscar","Blockbuster"), names(dataset)[[2]])
#     )
    
shinyUI(navbarPage("Movies Released 2008-2012",
                   
                   tabPanel("Movie Seasons",
                       fluidPage(
                           fluidRow(
                               column(2,
                                      h1("Movies by Release Date"),
                                      br(),
                                      h5("Group Populations By:"),
                                      radioButtons('popGroup', '', c("Oscar","Blockbuster"))
                                      ),
                               column(10,
                                      plotOutput("plotty",height="700px")
                                      )
                               ))
                    ),
                   tabPanel("Critics vs Audience",
                        fluidPage(
                            fluidRow(
                                column(2,
                                       h1("Ratings by Critics and Audience"),
                                       br(),
                                       h5("Please wait a moment for the graph to load"),
                                       br(),
                                       h5("* Scroll over any point to see more details"),
                                       br(),
                                       h5("* Click on the genres in the legend to filter")
                                       ),
                                column(10,
                                       showOutput("overrated", "NVD3")
                                       )
                                ))
                    ),
                   tabPanel("Financials by Genre",
                        fluidPage(
                            fluidRow(
                                column(2,
                                       h1("Genre Dollars & Cents"),
                                       br(),
                                       h5("Choose the Y axis:"),
                                       radioButtons('dollars', '', 
                                                    c("ProductionBudget",
                                                      "DomesticBoxOfficeToDate"))
                                       ),
                                column(10,
                                       plotOutput("boxplots",height="700px")
                                       )
                                ))
                    ),
                   tabPanel("What's on Netflix",
                        fluidPage(
                            fluidRow(
                                column(2,
                                       h1("Genre Dollars & Cents"),
                                       br(),
                                       h5("Choose the Y axis:"),
                                       radioButtons('dollars', '', 
                                                    c("ProductionBudget",
                                                      "DomesticBoxOfficeToDate"))
                                ),
                                column(10,
                                       showOutput("netflix", "NVD3")
                                )
                            ))
                    )
))