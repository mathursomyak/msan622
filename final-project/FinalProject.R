library(ggplot2)

# Load Data
movies <- read.csv("movies1.csv") # Has caldate
View(movies)

# Density of the Population
ggplot(data = movies)+
geom_density(#data=subset(movies, Nominations >0),
             aes(x=DomesticBoxOfficeToDate), 
             stat = "density", 
             position = "identity", 
             na.rm = FALSE)

# The Two New Fill Variables
OscarNomination <- as.factor(ifelse(movies$Nominations > 0, "Nominated", "NotNominated"))
BoxOfficeRevenue <- as.factor(ifelse(movies$DomesticBoxOfficeToDate > 100000000, "Over 100M", "Under 100M"))

# Create the Plot
ggplot(movies, aes(x = CalDate, fill=OscarNomination)) +
    geom_density(alpha=.3) +
    # Month labels for x axis
    scale_x_discrete(breaks=c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"),
                   labels=c("J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"),
                   expand=c(0,0)) +

    # Axes Titles
    labs( x = "Movie Release Date (In US)",
          y = "",
          title = "Density of Movies over Release Dates",
          fill = "Oscar Nominated") +
    
    # Theme
    theme( axis.ticks.y = element_blank()
          ,axis.text.y  = element_blank()
          ,legend.justification = c(0,1)
          ,legend.position = c(0,1)
           )


    




