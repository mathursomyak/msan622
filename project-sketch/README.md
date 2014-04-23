Project Sketch
==============================

| **Name**  | Somya Mathur  |
|----------:|:-------------|
| **Email** | mathursomyak@gmail.com |


Planned Tools
------------------------------
R tools: ggplot2 and Shiny
Other tools: python to interact with the sqlite database where this data is stored

Planned Techniques
------------------------------

1. Bubble plot showing the relationship between attributes of songs and their similarities. Color will represent genre, so it might be interesting
to see whether particular genres cluster at BPM ranges or octave levels. Size could represent popularity.

2. Small multiples plot showing the success of artists in different genres. This dataset has both a "hotness" and a "$ grossing" column. I can have
radio buttons to switch between views. Potentially, I could add a slider to represent timeframe or instead checkboxes for decades? I'm not sure yet.

3. Overview + Detail scatterplot of artist's "hotness" vs. "familiarity". Hotness is an artist's popularity now, and familiarity is how well known that 
artist is. 

4. Parallel Coordinates plot with each line representing an artist. Variables of potential interest include:
	counts of: biographies, blogs, images, news, reviews, songs, videos ;
	hotness measure, and familiarity measure.


Planned Interaction
------------------------------

1. Filtering based on genre, and double sliders for specifying x and y ranges of interest seem like appropriate interactions here.

2. [Interaction is mentioned above]

3. I'd like to add a search bar where you can look for an artist and if she appears in the dataset, you'll brush out everything but that
artist's datapoint

4. Connect this brushing to the brushing from plot 3. 

Planned Interface
------------------------------
Please see image in the repository