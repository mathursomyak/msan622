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
Rotten Tomatoes (https://pypi.python.org/pypi/rottentomatoes)  

Aggregating these data sources took a good amount of time. I wrote a python script, called
```NetflixAPI.py``` that creates the base data set. Plot 4 required the data to be in
a simplified format, so I created a separate csv file in the ```rcharts_experiment.R``` code.  

I made some decisions about more general genres than the ones provided by my data sources. The 
original number of genres was too many to code with colors, so I rolled-up genres like ```Comedy```,
```Romantic Comedy```,and ```Black Comedy``` into one Comedy genre. I called these rolled-up genres
```BigGenre``` in my dataset. My choices for combining smaller genres can be reviewed in the python
code.

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
(that were available through Rotten Tomatoes). I wanted to give the user the ability to hover over a movie (a point on the scatter plot) and see its title, oscar nomination status, critics score and audience score. The only way I know to do that is through rCharts. However, rCharts is a new tool for me and much documentation is still unavailable. I did have the opportunity to ask the creator of rCharts questions via the StackOverflow forum -- he was very helpful, but that process took some time.  
Overplotting was an issue here, but I thought that the user could combat that through the
magnify (aka zoom) and filtering options provided through the interface.

#### Graph 3 ####
I wanted to display differences in spending (and revenue) across genres of my dataset. Here again, I've used the ```BigGenre``` column. I thought the most convenient way for the user to see these
differences were though side-by-side box plots.  

To customize this plot, I simplified the types of boxes, chose not to show outliers, formatted the y-axis labels, and removed the background grid. Only horizontal lines are required for the user to compare useful information in this graph, so those are the only ones I kept in order to maximze the data-to-ink ratio.

#### Graph 4 ####
How many movies from each genre are on Netflix? The goal here was to show if there were particular genres that tend to come up on Netflix's roster more than others -- most likely because neflix users prefer them. This was my second plot in rCharts, which gives the interactivity to stack the bars to better see ratios.  

##Interactivity##  
This final project was my first time using rCharts which implements a great deal of interactivity for you, like zooming and filtering. I implemented interactivity to give users different "views" of the data. For example, one of the graphs allows you to choose what the y-axis will be.  

##Prototype Feedback##  
Unfortunately, this activity did not have much impact on my project because I changed the dataset I was using after we did this activity. However, it did give me ideas on things I could do in my own app. I think only one person in our group was far enough along, but not too far along in his app to allow the feedback to be realy useful.  

##Challenges##  
*I was unable to re-size the rCharts outputs (graphs 2 and 4)
*I cannot figure out why plot 4 sometimes doesn't show up (I think only when you try to run
it through ```runGitHub()```)  
*I wish I'd had time to implement more interactivity like filtering by genre in graph 1  
*In graph 4, I wanted to include counts by year, to see how many recent moviese are on Netflix