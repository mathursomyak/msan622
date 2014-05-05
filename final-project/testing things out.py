__author__ = 'skmathur'

def date_translate(date):
    month_translate = {"Jan":1,"Feb":2,"Mar":3,"Apr":4,"May":5,"Jun":6,"Jul":7,"Aug":8,"Sep":9,"Oct":10,"Nov":11,"Dec":12}
    d = date.split("-")
    f = month_translate[d[0]]+float(d[1])/31
    return f

print date_translate("Dec-8")