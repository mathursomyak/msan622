Homework 3: Multivariate
==============================

| **Name**  | Somya Mathur  |
|----------:|:-------------|
| **Email** | mathursomyak@gmail.com |

## Instructions ##
'''
library(shiny)
library(ggplot2)
library(RColorBrewer)
library(scales)
library(grid)
require(GGally)
require(plyr)

shiny::runGitHub("msan622", "mathursomyak", subdir = "homework3")
'''
## Discussion ##

####Bubble Plot####
My bubble plot shows the relationship between income and illiteracy.
The size of the bubbles can represent population, area, or population density.
I implemented filtering and zooming as required, and
also thought it would be interesting for the user to see which bubble represents
each state. So I added a checkbox that will display the state abbreviation for 
each bubble.

Stylistic Decisions: 
1. Change theme to minimalistic to keep graph less cluttered
2. Increased font sizes of almost everything on the graph (for readability)
3. Moved legend onto graph to best utilize real-estate
4. Made annotations about the x and y variables in the sidebar

####Small Multiples####
My Small Multiples show a break out of the bubble plot by region so it's easier 
to see trends by region.

####Parallel Coordinates####
This plot displays numeric values of population, income, illiteracy, Life
expectancy, murder, hs graduation, frost days, and area of the state. The colors
still represents the region. The plot is annotated with the min and max values for 
each feature