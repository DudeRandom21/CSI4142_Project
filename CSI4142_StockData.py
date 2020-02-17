#!/usr/bin/env python
# coding: utf-8

# In[7]:


import pandas as pd
import datetime
## Extracting Stock Data
Ids=['^DJI','^IXIC','^GSPC','CL=F','^GSPTSE']
description=['Dow Jones','NASDAQ','S&P500','Crude Oil', 'S&P500/TSE Composite']
df=pd.DataFrame()
import yfinance as yf
for i in range(len(Ids)):
    
    numdays = 2700
    base = datetime.datetime.today()
    date_list = [base - datetime.timedelta(days=x) for x in range(numdays)]
    x=pd.DataFrame()
    x['date']=date_list
    x['date']=x['date'].dt.date
    x['date']=pd.to_datetime(x['date'])
    data=yf.download(Ids[i], '2011-01-01',datetime.datetime.today())
    data['Index_ID']=description[i]
    data=data.reset_index()
    data=data.sort_values(by='Date', ascending=False)
    data=pd.merge(x, data, how='outer', left_on='date',right_on='Date')
    data=data.drop('Date',axis=1)
    data=data.sort_values(by='date', ascending=True)
    data=data.fillna(method='ffill')
    data=data.sort_values(by='date', ascending=False)
    df=df.append(data)
    


# In[9]:


# calculating the Average Change.
df = df.set_index('date').groupby(pd.Grouper(freq='d')).mean().dropna(how='all')
df=df.reset_index()
df=df.sort_values(by='date', ascending=True)

df['changeOpenClose'] = ((df["Open"] - df["Close"])/df["Open"])*100
df['changeLastDay'] = (df.Close.pct_change(periods=1))*100
df['changeLastWeek'] = (df.Close.pct_change(periods=7)) *100
df['changeLastMonth'] = (df.Close.pct_change(periods=30)) *100
df['changeLastYear'] = (df.Close.pct_change(periods=365)) *100
df=df.sort_values(by='date', ascending=False) 
df=df.drop(['Open','High','Low','Close','Adj Close','Volume'], axis=1)
df['stockKey']= 'NA stock Indexes'
mask = (df['date'] >= '2015-1-1') & (df['date'] <= '2017-12-31')
final_df=(df.loc[mask])
final_df=final_df.dropna()


# In[10]:


## Export to CSV
final_df.to_csv("C:\\Users\\zemdy\\Documents\\csi4142\\Project\\" + "StockData.csv", encoding='utf-8', index=False)


# In[12]:


final_df


# In[ ]:




