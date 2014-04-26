library(shiny)

shinyUI(
    navbarPage("UK Auto Deaths 1970 - 1985",

#FIRST TAB##############
   tabPanel("Stacked Area of Injury",
            sidebarLayout(
                sidebarPanel(
                    checkboxGroupInput("InjType", "Types:",
                                       c("Driver Killed" = "drKill",
                                         "Driver Injured" = "drInj",
                                         "Passenger Seat" = "front",
                                         "Back Seat" = "back"),
                                       c("drKill","drInj","front","back")
                                       ),
                    width=2
                ),
                mainPanel(plotOutput("area",height="600px"), width=10)
                
            )
    ) ,
   
   
   
#SECOND TAB#########
   tabPanel("People Hurt by Year",plotOutput("bars",height="600px"))
)
)