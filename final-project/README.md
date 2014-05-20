MSAN 622 Final Project: Movies
==============================

| **Name**  | Somya Mathur |
|----------:|:------------|
| **Email** | mathursomyak@gmail.com |

## Instructions ##  
require(devtools)  
install_github('rCharts', 'ramnathv')  
library(rCharts)  
library(ggplot2)   
library(plyr)
library(grid)
library(shiny)  
library(stats)


runGitHub("msan622", "mathursomyak", subdir = "final-project")  

The prefered method for running, however, is to download the directory 
and use the ```runApp()``` command. The fourth plot only appears when run this way.
I am still trying to fix this.

## Description ##

**Data**:  
All Movie Data (http://www.the-n
umbers.com/movies/)  
Netflix Data   (http://netflixroulette.net/api/)  
Academy Awards (http://en.wikipedia.org/wiki/List_of_Academy_Award-winning_films) 

#### Graph 1 ####  
I created a density plot that shows the density of Academy Award Nominated films
by their relesae dates throughout the year. This plot shows a marked pattern of 
"Oscar Season" -- it is clear that few Oscar nominees are released in May, for example.  
Similarly, the interactivity of this graph allows the user to view the "Blockbusters"
population by release date. Unsurprisingly, most block-busters are released in the summer 
and during the holiday break period.  
I customized this graph by choosing a low alpha so that both populations are easily visable. Ideally, I'd be able to subset the movies by genre. I was careful to include
only relevant information on the plot, and to maximize the size of the plot. I moved the 
legend and increased the plot height via Shiny to achieve maximal information.

#### Graph 2 ####  
This scatter plot shows how movies are perceived by critics vs. the lay audience. I used
the Rotton Tomatoes API to aquire rating information for all the movies in my dataset 
(that were available through Rotten Tomatoes). I wanted to give the user the ability to hover over a movie (a point on the scatter plot) and see its title, oscar nomination status, critics score and audience score. The only way I know to do that is through rCharts. However, rCharts is an extremely complicated tool that is still under development. Much documentation is still required.  
Overplotting was an issue here, but I thought that the user could combat that through the
zoom and filtering options provided through the interface.

#### Graph 3 ####
How many movies from each genre are on Netflix?

#### Graph 4 ####