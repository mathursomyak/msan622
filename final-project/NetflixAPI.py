__author__ = 'skmathur'
import csv
import sys
from NetflixRoulette import *

# Import and cleanup raw data
movies2012 = []
with open('supplementaryMovieInfo2008_12.csv', 'rb') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
    for row in spamreader:
        if row[0] == 'Release Date':
            headers = row
        elif row[1] != '':
            movies2012.append(row)

# Straighten up dataset: fill in dates, remove missing $ rows
current_date="1-Jan"
movies_data=[]
for row in movies2012:
    row.pop(5)
    if row[0] != '':
        current_date = row[0]
    else:
        row[0] = current_date
    try:
        if (int(row[4]) > 0) & (int(row[3])>0):
            movies_data.append(row)
    except: continue

# Supplement with Netflix Data
doing_netflix = False

if doing_netflix:
    for m,movie in enumerate(movies_data):
        title = movie[1]
        try: movie.append(get_media_rating(title))
        except: movie.append('NA')
else:
    for movie in movies_data:
        movie.append("NetflixRating")


# Supplement with Academy Award Info
AcademyAwards = []
    #read in Academy award data
with open('AcademyAwards.csv', 'rb') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
    for row in spamreader:
            AcademyAwards.append(row)
    #create a blank spot for award info
for movie in movies_data:
    movie.extend([0,0,0])
    #fill in award info
for awardMovie in AcademyAwards:
    for movie in movies_data:
        if movie[1] == awardMovie[0]:
            movie[-3:] = awardMovie[-3:]

# Add Convenient Date Format
def date_translate(date):
    month_translate = {"Jan":1,"Feb":2,"Mar":3,"Apr":4,"May":5,"Jun":6,"Jul":7,"Aug":8,"Sep":9,"Oct":10,"Nov":11,"Dec":12}
    d = date.split("-")
    f = month_translate[d[1]]+float(d[0])/31
    return f
for movie in movies_data:
    date = movie[0]
    try:
        cal  = date_translate(date)
        movie.append(cal)
    except:
        movie.append(2.9)
        print "bad date",date,len(date)


# Write out your new dataset
headers = ['ReleaseDate', 'Movie', 'Genre', 'ProductionBudget', 'DomesticBoxOfficeToDate','Year','NetflixRating','Awards','Nominations','BestPicture','CalDate']
with open('movies1.csv', 'wb') as csvfile:
    spamwriter = csv.writer(csvfile)
    spamwriter.writerow(headers)
    spamwriter.writerows(movies_data)




