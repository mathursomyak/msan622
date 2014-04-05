Homework 2: Interactivity
==============================

| **Name**  | [YOUR NAME]  |
|----------:|:-------------|
| **Email** | [USERNAME]@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

- `ggplot2`
- `shiny`

To run this code, please enter the following commands in R:

```
library(shiny)
shiny::runGitHub('msan622', 'mathursomyak', 'homework2')
```

This will start the `shiny` app. See below for details on how to interact with the visualization.

## Discussion ##

####Customization####
Plot Appearance: I decided to remove the gray background because it conflicted with the points that were "greyed out" while brushing.
The exact values of the points were of relatively little importance. Additionally, I removed gridlines, axis ticks and other features
that were cluttering the visualization. Because there was already so much going on with the data, I thought it would be best to remove
unnecessary information like that. I also set the default alpha low to provide the most visibility 
