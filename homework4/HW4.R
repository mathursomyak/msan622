require (wordcloud)
library(Rcpp)
library(wordcloud)
library(RColorBrewer)

AiW <- read.csv("C:/Users/skmathur/Documents/GitHub/msan622/homework4/AliceTextWordCloud1.csv")
View(AiW)

pal <- brewer.pal(8,"Blues")
pal <- pal[6:8]

wordcloud( words    = AiW$Word
           ,freq    = AiW$Count
           ,scale   = c(8,.4)
           ,min.freq= 25
           #,max.words =
           ,random.order=F
           #,random.color=T
           #,rot.per=
           ,colors = pal
           #,ordered.colors =
           ,use.r.layout = T
           ,fixed.asp = T
        
           )
