library(shiny)

shinyUI(
    navbarPage("UK Auto Deaths 1970 - 1985",

#FIRST TAB##############
   tabPanel("Stacked Area of Injury",
            sidebarLayout(
                sidebarPanel(
                    h3("Stacked Area of Death & Injury per Kilometer Driven"),
                    checkboxGroupInput("InjType", "Types:",
                                       c("Driver Killed" = "drKill",
                                         "Driver Injured" = "drInj",
                                         "Passenger Seat" = "front",
                                         "Back Seat" = "back"),
                                       c("drKill","drInj","front","back")
                                       ),
                    h5("Note: This dataset has counts of deaths and injuries in UK auto accidents per month"),
                    h5("A law was passed on Jan 31, 1983 requiring the use of seatbelts in the UK"),
                    width=2
                ),
                mainPanel(plotOutput("area",height="600px"), width=10)
                
            )
    ) ,
   
   
   
#SECOND TAB#########
   tabPanel("People Hurt by Year",plotOutput("bars",height="600px"))
)
)