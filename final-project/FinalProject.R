library(ggplot2)

# Load Data
movies <- read.csv("movies1.csv") # Has caldate
View(movies)
movies$Noms <- as.factor(movies$Nominations)
movies$Oscar <- as.factor(ifelse(movies$Nominations > 0, " Nominated", " Not Nominated"))

#ProductionBudget   DomesticBoxOfficeToDate
ggplot(data=movies, aes(x=NetflixStars, y=DomesticBoxOfficeToDate))+
    geom_smooth()+ 
    geom_jitter()+
    scale_y_log10()

ggplot(data=movies, aes(x=NetflixStars, y=DomesticBoxOfficeToDate))+
    geom_smooth()





    




