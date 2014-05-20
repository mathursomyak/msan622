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

**1. data encoding:** the y-axis is frequency and the x-axis is months of the year. Every movie from my dataset has a release date (with a separate column for year released), and I used a python function to turn that date into a number between 0 and 12 to make graphing more simple.  

**2. graph evaluation on lie factor, data density, and data to ink ratio:** Because this is a density plot of technically discrete data, there is some smoothing being done by ggplot, which means there is some lie factor. I believe this is justified in showing the major features of the graph. The data density is fairly high, because I put the legend on the graph and there's very little else on the display besides the data. The data to ink ratio isn't perfect because I chose to leave the grey back panel in this graph, but besides that, most of the ink is encoding some useful information.  

**3. graph strengths:** I designed this graph to show the patterns in the data. There is not much else the user can get from this graph except that oscar season is cyclical, and there are times of high-oscar-density, or hight-blockbuster-density and that those are not the same highs.  

**4. what I learned:** I did not expect there to be such dramatic differences between oscar season and the rest of the year.This shows me that movie directors know what kind of movie they're making and self-select into a specific timeframe during the year.  


#### Graph 2 ####
This scatter plot shows how movies are perceived by critics vs. the lay audience. I used
the Rotton Tomatoes API to aquire rating information for all the movies in my dataset 
(that were available through Rotten Tomatoes). I wanted to give the user the ability to hover over a movie (a point on the scatter plot) and see its title, oscar nomination status, critics score and audience score. The only way I know to do that is through rCharts. However, rCharts is a new tool for me and much documentation is still unavailable. I did have the opportunity to ask the creator of rCharts questions via the StackOverflow forum -- he was very helpful, but that process took some time.  
Overplotting was an issue here, but I thought that the user could combat that through the
magnify (aka zoom) and filtering options provided through the interface.  

**1. data encoding:** y-axis is audience score, x-axis is critic score, and color encodes BigGenre.  

**2. graph evaluation on lie factor, data density, and data to ink ratio:** The lie factor here is ~1 because I have not jittered the points or scaled by size. The data density within the graph is high, but the graph does not take up the whole space of the webpage. I believe the scroll over feature that gives more information about the point the user points to also increases the amount of data available from the graph. The data to ink ratio is high because there are no extra markings on the graph. I did include some notes in the side panel that are supposed to help the user interact with the graph, and I thought they were worth including even at the cost of some data-to-ink ratio.

**3. graph strengths:** This graph is excellent for outlier detection and some basic pattern recognition about differences between genres. In a scatter plot, it's very easy to see points that fall outside the usual pattern -- in this case those points are very low auidence score compared to critics score or visa-versa. There is also a patter that there are more dramas that are highly rated by both critics and the audience than most other genres.

**4. what I learned:** I was not aware of which movies were highly rated. I would have liked to implement a search type function where the user could free-form type in a movie title and if it was in the dataset, the searched movie would be highlighted. I did not have time to figure out if this was possible in rCharts.

#### Graph 3 ####
I wanted to display differences in spending (and revenue) across genres of my dataset. Here again, I've used the ```BigGenre``` column. I thought the most convenient way for the user to see these
differences were though side-by-side box plots.  

To customize this plot, I simplified the types of boxes, chose not to show outliers, formatted the y-axis labels, and removed the background grid. Only horizontal lines are required for the user to compare useful information in this graph, so those are the only ones I kept in order to maximze the data-to-ink ratio.  

**1. data encoding:** y-axis is either the Production Budget or the Box Office Revenue, and the x-axis has the BigGenre categories from my dataset, with box plots for each genre  

**2. graph evaluation on lie factor, data density, and data to ink ratio:** There is some lie factor here because I did not include the outliers in this analysis. It was too confusing and skewed the y-axis, making comparison more difficult. This graph has medium data density and high data to ink ratio. The data density isn't high because there is a lot of white space, but I found that this was the clearest way to represent the information.

**3. graph strengths:** Provides an excellent comparison between genres, and is ordered to facilitate the user in correctly interpreting the graph. 

**4. what I learned:** I did not know, prior to making this graph, that genres with higher budgets also tend to have higher revenue. Seeing as the drama genre had higher overall ratings (from graph 2) , I thought that perhaps Drama movies would see higher revenue at the box office as well. This plot disproved my hypothesis. Perhaps Action and Adventure movies gross more because people prefer to see those in theatres, but they can just watch a drama movie at home (on netflix perhaps...)

#### Graph 4 ####
How many movies from each genre are on Netflix? The goal here was to show if there were particular genres that tend to come up on Netflix's roster more than others -- most likely because neflix users prefer them. This was my second plot in rCharts, which gives the interactivity to stack the bars to better see ratios.  

## Interactivity ##
This final project was my first time using rCharts which implements a great deal of interactivity for you, like zooming and filtering. I implemented interactivity to give users different "views" of the data. For example, one of the graphs allows you to choose what the y-axis will be. Much of this interactivity is discussed above for individual graphs.  

## Prototype Feedback ##
Unfortunately, this activity did not have much impact on my project because I changed the dataset I was using after we did this activity. However, it did give me ideas on things I could do in my own app. I think only one person in our group was far enough along, but not too far along in his app to allow the feedback to be realy useful.  

## Challenges ##
#### Solved: ####
*Getting the data into a format that was easy to graph required constantly going back to tweak my Python code. By the end of this project, that python code is very sub-optimal. I forloop through the same list 5-6 times. It started running pretty slow. So I found the loop that ran the slowest, and made it optional to run without it. This sped-up my development process.  
*Customizing the ```tooltip``` in graph 2 was challenging because it involed writing a javascript-like function and there were no examples of what I wanted to do readily available online. I used stackoverflow to figure it out.  
*rCharts requires different syntax in shiny than ggplot2, it took a few hours of struggling to understand the renderChart{} syntax's equivalents in ggplot.  
#### Unsolved: ####
*I was unable to re-size the rCharts outputs (graphs 2 and 4)
*I cannot figure out why plot 4 sometimes doesn't show up (I think only when you try to run
it through ```runGitHub()```)  
*I wish I'd had time to implement more interactivity like filtering by genre in graph 1  
*In graph 4, I wanted to include counts by year, to see how many recent moviese are on Netflix