import requests
from bs4 import BeautifulSoup
import urllib
import pandas as pd
import json
from time import sleep, perf_counter as pf
import itertools as it

def scrape(month, year):
    url = 'https://www.timeanddate.com/sun/canada/vancouver?month={}&year={}'.format(month,year)
    page = requests.get(url).text

    soup = BeautifulSoup(page, 'html.parser')
    table = soup.find('tbody')
    rows = table.find_all('tr')

    lst = []
    for tr in rows:
        td = tr.find_all('td')
        # Catch the Daylight savings time problem
        if len(td) == 1:
            continue
        row = [data.text for data in td]
        lst.append(row)
    df = pd.DataFrame(lst, columns=["Sunrise", "Sunset", "a","b","c","d","e","f","g","h","i","j"])

    # Drop unused columns
    df.drop(df.columns.difference(["Sunrise", "Sunset"]), 1, inplace=True)
    
    return df

def format(df, month, year):
    # Discard Temperature
    df.Sunrise = df.Sunrise.str.replace(r'(?P<good>\d{1,2}\s+(?:am|pm)).*','\g<good>')
    df.Sunset = df.Sunset.str.replace(r'(?P<good>\d{1,2}\s+(?:am|pm)).*','\g<good>')

    # Reset index just for sanity
    df = df.reset_index(drop=True)

    # Add Day, Month and Year
    size = len(df.index)
    df.insert(0, 'Day', list(range(1,size+1)))
    df.insert(1, 'Month', [month]*size)
    df.insert(2, 'Year', [year]*size)

    # Format Time
    df['Sunrise'] = pd.to_datetime(df.Sunrise)
    df['Sunrise'] = df['Sunrise'].dt.strftime('%H:%M')

    df['Sunset'] = pd.to_datetime(df.Sunset)
    df['Sunset'] = df['Sunset'].dt.strftime('%H:%M')
    return df

def main():
    frames = []
    for year in range(2015, 2018):
        for month in range(1,13):
            raw = scrape(month, year)
            df = format(raw, month, year)
            frames.append(df)
    final = pd.concat(frames)
    final.to_csv(r'./output.csv', index=False)

if __name__ == "__main__":
    main()