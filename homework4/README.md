Homework [4]: Text Visualization
==============================

| **Name**  | Somya Mathur  |
|----------:|:-------------|
| **Email** | mathursomyak@gmail.com |

## Instructions ##

**Plot 1**

```library(sqldf)
library(ggplot2)
library(shiny)
shiny::runGitHub("msan622", "mathursomyak", subdir = "homework3")
```

**Plot 2**
[link]

**Plot 3**
(http://www-958.ibm.com/v/370602)

## Discussion ##

**Dataset**
I chose to use the text from the novel, "Alice's Adventures in Wonderland," because Lewis Carroll was my
favorite author growing up. I know this text has been much analyzed in the past, and has some interesting
patterns. 
I procured this data by downloading the Kindle E-book from Amazon. I then converted it into txt format 
using (www.zamzar.com/convert "Zamzar"). I first tried playing around with the text in ManyEyes, but found 
that punctuation was getting in the way, so I used Python to do some pre-processing on the text. The python
code and "cleaned" text are both in this repo folder.

**Plot 1**
My idea was to visualize the characters' appearances through the course of the novel. I wanted to be able
to see what each chapter was about over-all. I chose to create a histogram that shows the frequency of
characters' names mentioned in different chapters. I also made this plot animated through shiny, so a user
can quickly see the progression of the novel. Because I'd already pre-processed the data in python, rendering
plots in R did not take too long, and shiny doesn't create the change-blindness problem. I did some basic
customization: remove ticks, adjust axis gaps, label axes, increase font size, change colors, etc.

If I had more time, I'd like to make this plot more explorable -- I'd like a user to be able to choose which
characters to search for. But because the text processing was done in python, it would be a big undertaking
to make that work.

**Plot 2**

[ SAY STUFF ]

**Plot 3**
For my third plot, I chose to make a word tree using ManyEyes. I first tried this plot with the raw text and 
found that punctuation was causing strange results. I stripped the punctuation using my Python script, and
played around with different words. I tried "Alice","wonder","fell","fallen","cat","queen","believe",...etc.
I also experimented with putting my search word as the last word of the string. I found that the resulting
visualizations were much more difficult to understand, and didn't provide extra insight.

The word I found most interesting was "off", as it clearly showed the "Off with his/her head" scene. I also
feel that this word shows the style of language that's used in the novel overall. Carol often uses "off" to
mean "started" -- Alice spends most of the book "off" somewhere with someone.


