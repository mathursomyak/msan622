require(devtools)
install_github('rCharts', 'ramnathv')
library(rCharts)

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
Netflixed <- sqldf(
    "select OnNetflix,Genre,count(*) 
    from mymovies
    where Genre in ('Action','Adventure','Comedy','Drama','Horror','Romantic Comedy','Thriller/Suspense')
    group by OnNetflix, Genre
    order by count(*)")

names(Netflixed)[3] <- "Freq"
write.csv(file="Netflixed.csv", x=Netflixed)

NetflixedDF <- read.csv("Netflixed.csv")
n1 <- nPlot(Freq ~ Genre, group = "OnNetflix", data = NetflixedDF, type = "multiBarChart")
n1##n1$print("chart3")

# GRAPH 3
require(ggplot2)
BoxPlots <- sqldf(
    "select * 
    from mymovies
    where Genre in 
    ('Comedy','Action','Adventure','Drama','Horror','Romantic Comedy','Thriller/Suspense')")

write.csv(file="BoxPlots.csv", x=BoxPlots)
BoxPlots$Genre <- factor(BoxPlots$Genre,
                         levels= 
                             c('Drama','Horror','Thriller/Suspense','Comedy', 
                               'Romantic Comedy',"Action","Adventure"),
                         ordered = T)



# Label formatter for numbers in thousands.
million_formatter <- function(x) {
    return(sprintf("$%1.0f Mil", round(x / 1000000)))
}
ggplot(data=BoxPlots)+
    geom_boxplot(aes(x=Genre,y=ProductionBudget,fill=Genre),
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

