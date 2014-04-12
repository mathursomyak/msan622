library(shiny)
library(ggplot2)
library(RColorBrewer)
library(scales)
library(grid)
require(GGally)
require(plyr)

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
df$Income <- df$Income * 10

# Label formatter for numbers in thousands.
thousand_formatter <- function(x) {
    return(sprintf("$%dk", round(x / 1000)))
}
# Save Original Data
originalData <- df

#--------------
# Custom Theme
#--------------
theme_basic <- function(base_size = 12) (
    structure(list(
        axis.line =         theme_blank(),
        axis.text.x =       theme_text(size = base_size*0.8, lineheight = 0.9, colour = "grey50", vjust = 1),
        axis.text.y =       theme_text(size = base_size*0.8, lineheight = 0.9, colour = "grey50", hjust = 1),
        axis.ticks =        element_blank(),
        axis.title.x =      theme_text(size = base_size*1.2, vjust = 0.6),
        axis.title.y =      theme_text(size = base_size*1.2, angle = 90, vjust = 0.5),
        axis.ticks =        element_blank(),
        #axis.ticks.length = unit(0.15, "cm"),
        #axis.ticks.margin = unit(0.1, "cm"),
        
        legend.background = element_rect(colour="white", fill="white"), 
        legend.key =        element_rect(fill = "white", colour = "white"),
        legend.key.size =   unit(1.2, "lines"),
        legend.text =       element_text(size = base_size * 0.8),
        legend.title =      element_text(size = base_size * 0.8, face = "bold", hjust = 0),
        legend.position =   c(.9,.7),
        legend.direction=   "vertical",
        
        panel.background =  element_blank(), 
        panel.border =      element_blank(), 
        panel.grid.major =  element_blank(),
        panel.grid.minor =  element_blank(),
        #panel.margin =      unit(0.25, "lines"),
        
        strip.background =  element_rect(fill = "grey80", colour = NA), 
        strip.text.x =      element_text(size = base_size * 0.8),
        strip.text.y =      element_text(size = base_size * 0.8, angle = -90),
        
        plot.background =   element_rect(colour = NA, fill = "white"),
        plot.title =        element_text(size = base_size * 1.5),
        #plot.margin =       unit(c(0, 0, 0, 0), "lines")
        ), class = "options")
    )

#----------------
#Server Function
#----------------

shinyServer(function(input,output){
  
  #REACTIVE FUNcTionS
  data_to_graph <-reactive({subset(df,df$Region %in% (input$Regions))})
  x_lims <- reactive({input$x_lims})
  bub_size <- reactive({ input$bub_size })
  
  #CONSISTANT COLORS
  palette1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
                "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

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
      
    
      p <- p + scale_size_area(max_size = 40, guide = "none")
      p <- p + geom_point(alpha=0.65)
  
      # Modify the labels
      p <- p + labs(size = bubsize)
  
      # Force the dots to plot larger in legend
      p <- p + guides(colour = guide_legend(override.aes = list(size = 8)))
    
    
      # See State Names
      if(input$stateNames == TRUE){
          p <- p+geom_text(aes(label=Abbrev),hjust=0, vjust=0, color="black", size=4)
      }
    
      # Tweak the plot limits & Axes formats
      x_limits <- x_lims()
      p <- p + scale_x_continuous(
        limits = x_limits,
        labels = thousand_formatter,      
        expand = c(0, 0))
      
      p <- p + scale_y_continuous(
        limits = c(0, 3.5),
        expand = c(0, 0))
      
      # Pretty it up
      p <- p + theme_minimal()
      p<- p + theme(
        legend.text =       (element_text(size = 10)),
        legend.title =      element_blank(),
        legend.position =   c(.8,.95),
        legend.direction=   "horizontal",
        
        axis.text = (element_text(size = 13)),
        axis.title = (element_text(size = 30))
        )
      p <- p + scale_colour_discrete(limits = levels(originalData$Regions))

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
    p <- p + scale_size_area(max_size = 30, guide = "none")
    p <- p + geom_point(alpha=0.45)
    
    # Modify the labels
    p <- p + labs(size = "Population Density")
    
    # Force the dots to plot larger in legend
    p <- p + guides(colour = guide_legend(override.aes = list(size = 8)))
    
    # See State Names
    if(input$stateNames == TRUE){
      p <- p+geom_text(aes(label=Abbrev),hjust=0, vjust=0, color="black", size=4)
    }
    
    # Tweak the plot limits
    x_limits <- x_lims()
    p <- p + scale_x_continuous(
      labels = thousand_formatter,
      limits = x_limits,
      expand = c(0, 0))
    
    #Pretty it up
    p <- p + theme(
        legend.position = "none",
        strip.text = element_text(size = 13),
        axis.title = element_text(size = 30),
        axis.text =  element_text(size = 13))
    p <- p + scale_colour_discrete(limits = levels(originalData$Regions))
    print(p)
    
  })
  
  output$PCoord <- renderPlot({
    df <- data_to_graph()
    # Generate basic parallel coordinate plot
    p <- ggparcoord(data = originalData, 
                    
                    # Which columns to use in the plot
                    columns = 1:8, 
                    
                    # Which column to use for coloring data
                    groupColumn = 11, 
                    
                    # Allows order of vertical bars to be modified
                    order = "anyClass",
                    
                    # Do not show points
                    showPoints = FALSE,
                    
                    # Turn on alpha blending for dense plots
                    alphaLines = 0.6,
                    
                    # Turn off box shading range
                    shadeBox = NULL,
                    
                    # Will normalize each column's values to [0, 1]
                    scale = "uniminmax" # try "std" also
    )
    
    # Start with a basic theme
    p <- p + theme_minimal()
    
    # Decrease amount of margin around x, y values
    p <- p + scale_y_continuous(expand = c(0.02, 0.02))
    p <- p + scale_x_discrete(expand = c(0.02, 0.02))
    
    # Remove axis ticks and labels
    p <- p + theme(axis.ticks = element_blank())
    p <- p + theme(axis.title = element_blank())
    p <- p + theme(axis.text.y = element_blank())
    
    # Clear axis lines
    p <- p + theme(panel.grid.minor = element_blank())
    p <- p + theme(panel.grid.major.y = element_blank())
    
    # Darken vertical lines
    p <- p + theme(panel.grid.major.x = element_line(color = "#bbbbbb"))
    
    # Move label to bottom
    p <- p + theme(legend.position = "bottom")
    
    # Figure out y-axis range after GGally scales the data
    min_y <- min(p$data$value)
    max_y <- max(p$data$value)
    pad_y <- (max_y - min_y) * 0.1
    
    # Calculate label positions for each veritcal bar
    lab_x <- rep(1:8, times = 2) # 2 times, 1 for min 1 for max
    lab_y <- rep(c(min_y - pad_y, max_y + pad_y), each = 8)
    
    # Get min and max values from original dataset
    lab_z <- c(sapply(df[, 1:8], min), sapply(df[, 1:8], max))
    
    # Convert to character for use as labels
    lab_z <- as.character(lab_z)
    
    # Add labels to plot
    p <- p + annotate("text", x = lab_x, y = lab_y, label = lab_z, size = 7)
    
    # Display parallel coordinate plot
    print(p)
  })
})

