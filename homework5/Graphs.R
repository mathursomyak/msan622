
library(ggplot2)
library(reshape2) # melt
source("pretty.r")


# EXTRACT DATASET #####################
data(Seatbelts)

# creates x-axis for time series
times <- time(Seatbelts)

# extract years for grouping later
years <- floor(times)
years <- factor(years, ordered = TRUE)

# extract months by looking at time series cycle
cycle(times)        # 1 through 12 for each year
print(month.abb)    # month abbreviations

# store month abbreviations as factor
months <- factor(
    month.abb[cycle(times)],
    levels = month.abb,
    ordered = TRUE
)

# MOLTEN DATASET ######################

deaths <- data.frame(
    year    = years,
    month   = months,
    time    = as.numeric(times),
    drKill  = as.numeric(Seatbelts[,1]/Seatbelts[,5]),
    drInj   = as.numeric(Seatbelts[,1]),#wrong - will fix in stacked area section
    drivers     = as.numeric(Seatbelts[,2]/Seatbelts[,5]),
    front       = as.numeric(Seatbelts[,3]/Seatbelts[,5]),
    back        = as.numeric(Seatbelts[,4]/Seatbelts[,5]),
    petrol      = as.numeric(Seatbelts[,6]),
    vankill    = as.numeric(Seatbelts[,7]),
    kms     = as.numeric(Seatbelts[,5])
)


# BAR PLOT ####################

deathsByYear <- sqldf(
    "select year,
        avg(drivers),
        avg(front),
        avg(back),
        avg(petrol),
        avg(vankill),
        avg(kms)
    from deaths group by year"
)
names(deathsByYear)<- c('year','drivers','front','back','petrol','vankill','kms')
deathsByYear$all <- deathsByYear$drivers+deathsByYear$front+deathsByYear$back

#View(deathsByYear)
p <- ggplot(deathsByYear, aes(x=year, y=all))+geom_bar(stat="identity")
#p <- p+ scale_y_discrete(expand = c(0,0), limits=c(0,0.3))
p <- p+ xlab("Year") + ylab("People Hurt / KM driven")
p <- p+ ggtitle("People Hurt in Car Accidents")
p <- p+ theme(
    axis.ticks = element_blank(),
    panel.background = element_blank(),
    plot.title = element_text(size = 45),
    axis.text = element_text(size=10),
    axis.title = element_text(size=32),
    panel.grid = element_blank()
    #axis.text.x = element_text(vjust= +5)
)

p <- p + annotate("text", x = 12.3, y = .25:.3, label = c("before law"),size=10,color="red",hjust=1)
p <- p + annotate("segment",x = 12.8, xend=12.8, y=0,yend=.3,color="grey",linetype="dashed",size = 1.5)
p <- p + annotate("text", x = 13, y = .25:.3, label = c("after law"),size=10,color="blue",hjust=0)

p

# STACKED AREA #################
deaths$drInj <- deaths$drivers - deaths$drKill
molten <- melt(
    deaths[,1:8],
    id = c("year", "month", "time")
)
#View(molten)

p <- ggplot(molten, aes(x = time, y = value))
p <- p + geom_area(
    data = subset(molten, variable != "drivers"),
    aes(
        group = variable,
        fill = variable,
        # not really necessary
        color = variable,
        # swap stacking order
        order = -as.numeric(variable)
    )
)
# make it pretty
p <- p + scale_year()
p <- p + theme_legend()
p


