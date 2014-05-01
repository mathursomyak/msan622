library(ggplot2)

songdata <- read.csv("myDataar.csv")
head(songdata)
names(songdata)
as.factor(songdata$term)
ggplot(data=songdata) + geom_point(aes(x=artist_hotttnesss,y=artist_familiarity,size=4,color=term,alpha=.05))

artdata <- read.csv("myDatbyArt.csv")
names(artdata)
artdata$blackorigin <- artdata$term %in%
    c('hip hop',
    'jazz',
    'r&b',
    'rap',
    'reggae',
    'soul')
artdata$contemporary <- artdata$term %in%
    c('electronic',
      'hip hop',
      'house',
      'indie',
      'pop',
      'pop rock',
      'rap',
      'rock',
      'techno')
artdata$guitarbased <- artdata$term %in%
    c('acoustic',
      'alternative',
      'folk',
      'indie',
      'instrumental',
      'metal',
      'punk',
      'rock'
      )


ggplot(data=artdata) + 
    geom_point(aes(x=artist_hotttnesss,y=artist_familiarity,size=5,color=blackorigin,alpha=.5))


ggplot(data=artdata) + 
    geom_point(aes(x=artist_hotttnesss,y=artist_familiarity,size=5,color=term,na.rm=T))

ggplot(data=artdata) + 
    geom_point(aes(x=artist_hotttnesss,y=artist_familiarity,size=5,color=contemporary,na.rm=T))

