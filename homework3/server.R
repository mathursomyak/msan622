library(shiny)
library(ggplot2)
library(RColorBrewer)
library(scales)
require(GGally)

#runGitHub("msan622", "mathursomyak", subdir = "homework3")

#Munging
#--------
df <- data.frame(state.x77,
                 State = state.name,
                 Abbrev = state.abb,
                 Region = state.region,
                 Division = state.division
)
df$PopDensity <- df$Population/df$Area



#Server Function
#----------------

shinyServer(function(input,output){
  
  #REACTIVE FUNcTionS
  data_to_graph <-reactive({subset(df,df$Region %in% (input$Regions))})
  x_lims <- reactive({input$x_lims})
  bub_size <- reactive({ input$bub_size })

  #PLOTTING!
  output$bubblePlot <- renderPlot({
    df <- data_to_graph()
    df <- df[order(-df$Population),]
    bubsize <- bub_size()
 
    #Bubble Plot
    if (bubsize == "Population"){
      p <- ggplot(data=data_to_graph(), 
                  aes(x=Income,
                      y=Illiteracy,
                      color=Region,
                      size= Population
                      )
      )}
    else if (bubsize == "PopDensity"){
      p <- ggplot(data=data_to_graph(), 
                  aes(x=Income,
                      y=Illiteracy,
                      color=Region,
                      size= PopDensity)
      )}
    else{p <- ggplot(data=data_to_graph(), 
                     aes(x=Income,
                         y=Illiteracy,
                         color=Region,
                         size= Area)
      )}
      
    
      p <- p + scale_size_area(max_size = 20, guide = "none")
      p <- p + geom_point(alpha=0.65)
  
      # Modify the labels
      p <- p + labs(size = "Population Density")
  
      # Force the dots to plot larger in legend
      p <- p + guides(colour = guide_legend(override.aes = list(size = 8)))
  
      # See State Names
      if(input$stateNames == TRUE){
        p <- p+geom_text(aes(label=Abbrev),hjust=0, vjust=0)#, color="black")
      }
    
      # Tweak the plot limits
      x_limits <- x_lims()
      p <- p + scale_x_continuous(
        limits = x_limits,
        expand = c(0, 0))
      
      p <- p + scale_y_continuous(
        limits = c(0, 3.5),
        expand = c(0, 0))
      
      # Pretty it up
      p <- p + theme()


      print(p)  


  })
  
  output$smaMult <- renderPlot({
    df <- data_to_graph()
    df <- df[order(-df$Population),]
    bubsize <- bub_size()
    
    #Bubble Plot
    if (bubsize == "Population"){
      p <- ggplot(data=data_to_graph(), 
                  aes(x=Income,
                      y=Illiteracy,
                      color=Region,
                      size= Population
                  )
      )}
    else if (bubsize == "PopDensity"){
      p <- ggplot(data=data_to_graph(), 
                  aes(x=Income,
                      y=Illiteracy,
                      color=Region,
                      size= PopDensity)
      )}
    else{p <- ggplot(data=data_to_graph(), 
                     aes(x=Income,
                         y=Illiteracy,
                         color=Region,
                         size= Area)
    )}
    
    p <- p + facet_wrap(~ Region)
    p <- p + scale_size_area(max_size = 20, guide = "none")
    p <- p + geom_point(alpha=0.45)
    
    # Modify the labels
    p <- p + labs(size = "Population Density")
    
    # Force the dots to plot larger in legend
    p <- p + guides(colour = guide_legend(override.aes = list(size = 8)))
    
    # See State Names
    if(input$stateNames == TRUE){
      p <- p+geom_text(aes(label=Abbrev),hjust=0, vjust=0, color="black", size=8)
    }
    
    # Tweak the plot limits
    x_limits <- x_lims()
    p <- p + scale_x_continuous(
      limits = x_limits,
      expand = c(0, 0))
    print(p)
    
  })
})

#========================================================
# Generate basic parallel coordinate plot
# p <- ggparcoord(data = df, 
#                 
#                 # Which columns to use in the plot
#                 columns = 2:7, 
#                 
#                 # Which column to use for coloring data
#                 groupColumn = 3, 
#                 
#                 # Allows order of vertical bars to be modified
#                 #order = "anyClass",
#                 
#                 # Do not show points
#                 #showPoints = FALSE,
#                 
#                 # Turn on alpha blending for dense plots
#                 alphaLines = 0.6,
#                 
#                 # Turn off box shading range
#                 shadeBox = NULL,
#                 
#                 # Will normalize each column's values to [0, 1]
#                 scale = "uniminmax" # try "std" also
# )
# p <- p + theme_minimal()
# dim(df[,2:7])
# length(df[,3])
# p
