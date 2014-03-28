Homework 1: Basic Charts
==============================

| **Name**  | Somya Mathur  |
|----------:|:-------------|
| **Email** | skmathur2@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

- `ggplot2`
- `devtools`
- `sqldf`

To run this code, please enter the following commands in R:

```
library(devtools)
library(ggplot2)
source_url("https://github.com/mathursomyak/msan622/blob/master/homework1/Homework_1.R")
```

This will generate 4 image files. See below for details.

## Discussion ##

### Bar Plot ###
This Bar plot shows the frequencies of movie genres in our dataset. 
####Adjustments to Defaults####
> * I gave the plot a title
> * re-organized the bars so that they are in ascending order
> * tilted the genre labels and resized them to make them more legible

### Scatter Plot ###
This plot shows the density of data points with their positions
####Adjustments to Defaults####
> * I gave the plot a title to give it more "story"
> * changed the opaqueness & color of the points to see the density better
> * labeled the axes

### Small Multiples Plot ###
This is a display of several plots broken out by some factor
####Adjustments to Defaults####
> * I gave the plot a title to give it more "story"
> * added a red line to show the average of each genre for better comparison
> * labeled the axes, and tilted the labels

### Multiline Plot ###
This is a display of several time series on the same plot
####Adjustments to Defaults####
> * titled the plot and the legend
> * Changed the colors of the lines
> * labeled the axes











