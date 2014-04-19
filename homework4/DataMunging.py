__author__ = 'skmathur'
import string
import re
from sklearn.feature_extraction.text import CountVectorizer
import csv

AliceNoPunct = ""
with open("AliceInWonderland.txt","r") as b:
    for line in b:
        out = line.translate(None,string.punctuation)
        AliceNoPunct = AliceNoPunct+" "+out

#Text for ManyEyes:
#print AliceNoPunct


listy = AliceNoPunct.split('\n')
chapterText=[]
thisChapter = ""
for i in range(len(listy)):
    if listy[i]not in ['','\n',' ']: #only process if not blank
        thisChapter = thisChapter+' '+listy[i].upper()
        if listy[i][1:8]=='CHAPTER':
            chapterText.append(thisChapter)
            thisChapter = ''
chapterText.append(thisChapter)

names = ['alice','sister','rabbit','cat','queen','king','caterpillar','madhatter','jacks']
myCsv = []
for c in range(1,13):   #skip before first chapter
    words,counts = None,0
    Chapter = chapterText[c].split()
    CountVec = CountVectorizer(min_df=2, stop_words='english',ngram_range=(1,2))
    X = CountVec.fit_transform(Chapter)
    x = X.toarray()
    words = CountVec.get_feature_names()
    counts = (x.sum(axis=0))
    #newCH = [[c,words[i],counts[i]] for i in range(len(words))]
    CH = []
    for n in names:
        if n in words:
            i = words.index(n)
            CH.append([c,n,counts[i]])
        else: CH.append([c,n,0])

    myCsv.extend(CH)

csvName = "AliceTextbyCh.csv"
with open(csvName,'wb') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(['Chapter','Word','Count'])
    writer.writerows(myCsv)


#print names.index("somya")
#for i in range(len(words)):
#    print i,counts[i],words[i]