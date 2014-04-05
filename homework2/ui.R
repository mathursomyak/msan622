shinyUI(pageWithSidebar(
  headerPanel("IMDB Movie Ratings"),

  # SIDE BAR PANEL WITH SWITCHES
  sidebarPanel(
    radioButtons("MPAA_Rating", 
          label = h4("MPAA Rating"), 
          choices = list("PG" = 1, 
                         "PG-13" = 2, 
                         "R" = 3, 
                         "NC-17" = 4, 
                         "All" = 5),
          selected = 5),  
    checkboxGroupInput("Genres", 
          label = h4("Movie Genre"),
          choices = list("Action" = 1, 
                         "Animation" = 2, 
                         "Comedy" = 3,
                         "Drama" = 4,
                         "Documentary" = 5,
                         "Romance" = 6,
                         "Short" = 7),
          selected = c(1,2,3,4,5,6,7)), 
     
     selectInput("palette", label = h4("Color Scheme"), 
           choices = list("Mermaid" = "Set1", "Bright" = "Set2", "Light" = "Set3", "Autumn" = "Dark2"), 
           selected = "Dark2"),
    
     sliderInput("size", label = h4("Dot Size"),
           min = 0, max = 10, value = 3),
    
     sliderInput("alpha", label = h4("Dot Opacity"),
           min = 0.1, max = 1, value = 0.3)
  ),
  # GRAPH IS DISPLAYED
  mainPanel(
    #textOutput("text1"),
    plotOutput("scatterPlot")
  )
))