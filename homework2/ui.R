shinyUI(pageWithSidebar(
  headerPanel("IMDB Movie Ratings"),

  # SIDE BAR PANEL WITH SWITCHES
  sidebarPanel(
    radioButtons("MPAA_Rating", 
          label = h4("MPAA Rating"), 
          choices = list("PG" = "PG", 
                         "PG-13" = "PG-13", 
                         "R" = "R", 
                         "NC-17" = "NC-17",
                         "All" = "All"
                         ),
          selected = "All"),  
    checkboxGroupInput("Genres", 
          label = h4("Movie Genre"),
          choices = list("Action" = "Action", 
                         "Animation" = "Animation", 
                         "Comedy" = "Comedy",
                         "Drama" = "Drama",
                         "Documentary" = "Documentary",
                         "Romance" = "Romance",
                         "Short" = "Short",
                         "Mixed" = "Mixed",
                         "None" = "None"),
          selected = NULL), #c("Action",'Animation','Comedy','Drama','Documentary','Romance','Short','Mixed','None')), 
     
     selectInput("palette", label = h4("Color Scheme"), 
           choices = list("Mermaid" = "Set1", "Bright" = "Set2", "Light" = "Set3", "Autumn" = "Dark2"), 
           selected = "Dark2"),
    
     sliderInput("dot_size", label = h4("Dot Size"),
           min = 0, max = 10, value = 3),
    
     sliderInput("dot_alpha", label = h4("Dot Opacity"),
           min = 0.1, max = 1, value = 0.3)
  ),
  # GRAPH IS DISPLAYED
  mainPanel(
    #textOutput("text1"),
    plotOutput("scatterPlot")
  )
))


