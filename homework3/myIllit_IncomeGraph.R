library(shiny)
library(ggplot2)
library(RColorBrewer)
library(scales)
require(GGally)
library(grid)

runGitHub("msan622", "mathursomyak", subdir = "homework3")

#Munging
df <- data.frame(state.x77,
                 State = state.name,
                 Abbrev = state.abb,
                 Region = state.region,
                 Division = state.division
)
df$PopDensity <- df$Population/df$Area
df <- df[order(-df$Population),]

#Bubble Plot
#----------------
p <- ggplot(data=df, 
            aes(x=Income,
                y=Illiteracy,
                color=Region,
                size=Population)
            ) 
p <- p + scale_size_area(max_size = 15, guide = "none")
p <- p + geom_point(alpha=0.65)

# Modify the labels
p <- p + ggtitle("US Illiteracy by Income")
p <- p + labs(size = "Population Density")

# Force the dots to plot larger in legend
p <- p + guides(colour = guide_legend(override.aes = list(size = 8)))
  
# Indicate size is population density
p <- p + annotate(
  "text", x = 3500, y = 2.65,
  hjust = 0, color = "grey40",
  label = "Circle area is proportional to state population.")