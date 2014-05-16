require(devtools)
install_github('rCharts', 'ramnathv')
library(rCharts)
library(sqldf)

mymovies <-read.csv("movies3.csv")

r2 <- rPlot(RottenTomatosAudienceScore ~ RottenTomatosCriticsScore, 
            data = mymovies,
            color = 'BigGenre', 
            type='point',
            point = list(events = list(click = "#!function(item){ alert( 'x: ' + item.x + ' y: ' + item.y + ' id: ' + item.Movie); }!#")),
            tooltip = "#!function(item){ return item.Movie + ' ' + '('+item.Year+')'}!#")
r2


p1 <- nPlot(RottenTomatosAudienceScore ~ RottenTomatosCriticsScore,
            group = 'BigGenre', 
            data = mymovies, 
            type = 'scatterChart')
p1$xAxis(axisLabel = 'Critics Score')
p1$yAxis(axisLabel = 'Audience Score')
p1

# GRAPH 4
        #where Genre in ('Action','Adventure','Comedy','Drama','Horror','Romantic Comedy','Thriller/Suspense')
Netflixed <- sqldf(
    "select OnNetflix,BigGenre,count(*),avg(NetflixStars)
    from mymovies
    group by OnNetflix, BigGenre
    order by count(*)")

names(Netflixed)[3:4] <- c("Freq","NetflixStars")
write.csv(file="Netflixed.csv", x=Netflixed)

NetflixedDF <- read.csv("Netflixed.csv")
n1 <- nPlot(Freq ~ BigGenre, group = "OnNetflix", data = NetflixedDF, type = "multiBarChart")
n1##n1$print("chart3")
n2 <- nPlot(NetflixStars ~ BigGenre, data = subset(Netflixed,Netflixed$OnNetflix=="On Netflix"),type="multiBarChart")
n2
# GRAPH 3
require(ggplot2)

mymovies$BigGenre <- factor(mymovies$BigGenre,
                         levels= 
                             c('Drama','Horror','Thriller/Suspense','Comedy', 
                               'Romantic Comedy',"Action","Adventure","Other"),
                         ordered = T)



# Label formatter for numbers in thousands.
million_formatter <- function(x) {
    return(sprintf("$%1.0f Mil", round(x / 1000000)))
}
ggplot(data=mymovies)+
    geom_boxplot(aes(x=BigGenre,y=ProductionBudget,fill=BigGenre),
                 alpha = 0.6,
                 stat = "boxplot", position = "dodge",
                  outlier.size = 0, notch = FALSE)+
    guides(fill=F)+
    scale_fill_manual(values=
                          c("#66c2a5","#fc8d62","#8da0cb",
                            "#e78ac3","#a6d854","#ffd92f","#e5c494"))+
    theme(
        panel.background = element_blank(),
        panel.grid.major.y = element_line(color='grey'),
        panel.grid.major.x = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_text(color='black')
        )+
    scale_y_continuous(
        limits = c(0,300000000),
        labels = million_formatter,      
        expand = c(0, 0))
    #coord_flip()
    
sqldf("select Genre,count(*) from mymovies group by Genre")

