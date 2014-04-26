Homework 5 : Temporal Visualization
==============================

| **Name**  | Somya Mathur  |
|----------:|:-------------|
| **Email** | mathursomyak@gmail.com |

## Instructions ##

'''
library(shiny)
library(ggplot2)
library(RColorBrewer)
library(sqldf)

shiny::runGitHub("msan622", "mathursomyak", subdir = "homework5")
'''

## Discussion ##

Plot 1:
Stacked area plot of different types of death/injuries from the dataset. I removed the 'drivers'
column because I thought it would be misleading to include a column which is a sum of injuries and 
deaths as well as just a deaths column. So I subtracted off the deaths from the drivers column and
called it the Driver Injuries

Plot 2:
I wanted to show something simple with a line for before and after the law went into affect. I think
the simplicity of this plot is its strenght: it shows that there was a declining trend in the number
of deaths and injuries anyway, and the seatbelt law helped. I averaged these numbers per year to smooth
out some of the noise that makes it difficult to see the pattern.
