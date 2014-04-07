library(ggplot2)
library(shiny)
library(scales)
library(RColorBrewer)


#Data Cleaning
data(movies)

movies <- subset(movies,budget>0) #filter out movies with a negative budget
movies <- subset(movies,(mpaa)!='') #filter out movies without an mpaa rating

genre <- rep(NA, nrow(movies))
count <- rowSums(movies[, 18:24])
genre[which(count > 1)] = "Mixed"
genre[which(count < 1)] = "None"
genre[which(count == 1 & movies$Action == 1)] = "Action"
genre[which(count == 1 & movies$Animation == 1)] = "Animation"
genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
genre[which(count == 1 & movies$Drama == 1)] = "Drama"
genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
genre[which(count == 1 & movies$Romance == 1)] = "Romance"
genre[which(count == 1 & movies$Short == 1)] = "Short"
movies$genre <- factor(genre, levels = c("Action","Animation","Comedy","Documentary","Drama","Romance","Short","Mixed","None"))
movies$mpaa <- factor(movies$mpaa, levels = c("NC-17","R","PG-13","PG"))

genres <- levels(movies$genre)
mpaas <- levels(movies$mpaa)

#Plot Theme
#====================================================================
# myTheme <- theme(text = element_text(size = 16, colour = "#252525"), 
#                 axis.text.x = element_text(colour = "#252525"), 
#                 axis.text.y = element_text(colour = "#252525"),
#                 axis.ticks = element_line(colour = "#252525"),
#                 
#                 #axis.title.x = element_text(vjust = -1.25), 
#                 #axis.title.y = element_text(vjust = -0.1),
#                 
#                 plot.background = element_blank(),
#                 plot.margin = unit(c(1, 1, 0, 0), "cm"),
#                 
#                 panel.background = element_blank(),
#                 panel.grid = element_blank(),
#                 
#                 line = element_line(colour = 'gray'),
#                 axis.line = element_line(colour = 'gray'),
#                 legend.position = 'right',
#                 legend.title = element_blank(),
#                 legend.background = element_blank(),
#                 legend.key = element_blank())
#====================================================================
  
#Server Function
shinyServer(function(input,output){
    #Get 2 DFs for Brushing            
    getdata <- reactive({
      
      # Highlight and Brushing    
 
      input$MPAA_Rating
      input$Genres
      if (input$MPAA_Rating == 'All'){
        highlight <- subset(movies, movies$genre %in% input$Genres)
        inactive  <- subset(movies, !movies$genre %in% input$Genres)
        }
      else {
        highlight <- subset(movies, (movies$genre %in% input$Genres) & (movies$mpaa == input$MPAA_Rating))
        inactive  <- subset(movies, (!movies$genre %in% input$Genres) & (movies$mpaa != input$MPAA_Rating))
        }
      # Return the active and inactive partitions of the data
      current <- list(highlight, inactive)
      names(current) <- c('highlight', 'inactive')
      return(current)
    })
  
    output$scatterPlot <- renderPlot({
      
      # Adjust color
      color <- c(brewer.pal(length(levels(movies$genre)), input$palette), "#f0f0f0")
      names(color) <- c(genres)
      
      # Get the data
      inactive <- getdata()[['inactive']]
      active <- getdata()[['highlight']]

      # Plot inactive data, if any    
      if (nrow(inactive) > 0) {
        p <- ggplot(data = inactive, aes(x = budget, y = rating)) + 
          geom_point(alpha = .1, size = input$dot_size, color = "grey")
      } else {
        p <- ggplot()
      }
      
      # Plot active data, if any
      if (nrow(active) > 0 ) {
        p <- p + geom_point(data = active,
                            alpha = input$dot_alpha,
                            size = input$dot_size,
                            aes(x = budget, y = rating, colour = genre)) 
          +guides(colour = guide_legend(override.aes = list(shape = 15, size = 10)))
      }
      #p <- p + myTheme
      print(p)
    })
    options(error = browser)
    

})
