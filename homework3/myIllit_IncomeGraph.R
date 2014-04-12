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


# Custom Theme
theme_minimal <- function(base_size = 12) (
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
        
        legend.background = theme_rect(colour="white", fill="white"), 
        legend.key =        theme_rect(fill = "white", colour = "white"),
        legend.key.size =   unit(1.2, "lines"),
        legend.text =       theme_text(size = base_size * 0.8),
        legend.title =      theme_text(size = base_size * 0.8, face = "bold", hjust = 0),
        legend.position =   c(.9,.7),
        legend.direction=   "vertical"
        
        panel.background =  element_blank(), 
        panel.border =      theme_blank(), 
        panel.grid.major =  theme_blank(),
        panel.grid.minor =  theme_blank(),
        panel.margin =      unit(0.25, "lines"),
        
        strip.background =  theme_rect(fill = "grey80", colour = NA), 
        strip.text.x =      theme_text(size = base_size * 0.8),
        strip.text.y =      theme_text(size = base_size * 0.8, angle = -90),
        
        plot.background =   theme_rect(colour = NA, fill = "white"),
        plot.title =        theme_text(size = base_size * 1.5),
        plot.margin =       unit(c(0, 0, 0, 0), "lines")
    ), class = "options")
)