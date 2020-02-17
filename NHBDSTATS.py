#!/usr/bin/env python
# coding: utf-8

# In[7]:


import pandas as pd
denver=pd.read_csv("C:\\Users\\zemdy\\Documents\\csi4142\\Project\\DenverNrhdData20132017.csv")
vancouver=pd.read_excel("C:\\Users\\zemdy\\Documents\\csi4142\\Project\\Vancouver.xlsx",skiprows=4)
import warnings
warnings.filterwarnings('ignore')


# In[21]:


denver=denver.set_index('NBHD_NAME')


# In[307]:


Dstats=denver[['TTL_POPULATION_ALL',
 'PCT_HISPANIC',
 'PCT_WHITE',
 'PCT_BLACK',
 'PCT_NATIVEAM',
 'PCT_ASIAN',
 'PCT_HAWAIIANPI',
 'PCT_OTHERRACE',
'MALE',
 'FEMALE',
 'AGE_10_TO_19',
 'AGE_20_TO_29',
 'AGE_30_TO_39',
 'AGE_40_TO_49',
 'AGE_50_TO_59',
 'AGE_60_TO_69',
 'AGE_70_TO_79',
 'AGE_80_PLUS',
 'MEDIAN_AGE_ALL',
 'MEDIAN_AGE_MALE',
 'MEDIAN_AGE_FEMALE',
     'PCT_POVERTY',
 'PER_CAPITA_INCOME' ]]


# In[24]:


df_list = np.split(vancouver, vancouver[vancouver.isnull().all(1)].index) 


# In[342]:


Vage=df_list[0]
vage1=Vage.drop('ID',axis=1).set_index('Variable').transpose()
vage1=vage1[[' Total - Age groups and average age of the population - 100% data ','  Total - Age groups and average age of males - 100% data',
              '  Total - Age groups and average age of females - 100% data','    10 to 14 years', '  15 to 64 years', '    15 to 19 years',
       '    20 to 24 years', '    25 to 29 years', '    30 to 34 years',
       '    35 to 39 years', '    40 to 44 years', '    45 to 49 years',
       '    50 to 54 years', '    55 to 59 years', '    60 to 64 years',
       '  65 years and over', '    65 to 69 years', '    70 to 74 years',
       '    75 to 79 years', '    80 to 84 years', '    85 years and over']]
vage1['AGE_10_TO_19']=vage1['    10 to 14 years']+vage1[ '    15 to 19 years']
vage1['AGE_20_TO_29']=vage1['    20 to 24 years']+vage1[ '    25 to 29 years']
vage1['AGE_30_TO_39']=vage1['    30 to 34 years']+vage1[ '    35 to 39 years']
vage1['AGE_40_TO_49']=vage1['    40 to 44 years']+vage1[ '    45 to 49 years']
vage1['AGE_50_TO_59']=vage1['    50 to 54 years']+vage1[ '    55 to 59 years']
vage1['AGE_60_Over']=vage1['    60 to 64 years']+vage1[ '  65 years and over']
vage1=vage1.reset_index()
vage1=vage1[['index',' Total - Age groups and average age of the population - 100% data ', '  Total - Age groups and average age of males - 100% data',
       '  Total - Age groups and average age of females - 100% data','AGE_10_TO_19', 'AGE_20_TO_29', 'AGE_30_TO_39', 'AGE_40_TO_49',
       'AGE_50_TO_59', 'AGE_60_Over']]
vage1_rename=['NBHD_NAME','TTL_POPULATION_ALL','MALE',
 'FEMALE','AGE_10_TO_19', 'AGE_20_TO_29','AGE_30_TO_39', 'AGE_40_TO_49',
       'AGE_50_TO_59', 'AGE_60_OVER']
vage1.columns=vage1_rename
vage1=vage1.set_index('NBHD_NAME')


# In[286]:


medianAge=df_list[3]
medianAge=medianAge.drop('ID',axis=1).set_index('Variable').transpose()
medianAge=medianAge[['Median age of the population',
                    '  Median age of males',
                 '  Median age of females']]
medianAge_rename=['NBHD_NAME','MEDIAN_AGE_ALL',
 'MEDIAN_AGE_MALE',
 'MEDIAN_AGE_FEMALE']
medianAge=medianAge.reset_index()
medianAge.columns=medianAge_rename

medianAge=medianAge.set_index('NBHD_NAME')


# In[297]:


vIncome=df_list[23]
vIncome=vIncome.dropna(how='all')
vIncome=vIncome.drop('ID',axis=1).set_index('Variable').transpose()
vIncome=vIncome[['    Median total income in 2015 among recipients ($)']]
vIncome_rename=['NBHD_NAME','PER_CAPITA_INCOME']
vIncome=vIncome.reset_index()
vIncome=vIncome[['index','    Median total income in 2015 among recipients ($)']]
vIncome.columns=vIncome_rename
vIncome=vIncome.set_index('NBHD_NAME')


# In[287]:


lowIncome=df_list[31]
lowIncome=lowIncome.drop('ID',axis=1).set_index('Variable').transpose()
lowIncome=lowIncome[['Prevalence of low income based on the Low-income measure, after tax (LIM-AT) (%)',]]
lowIncome=lowIncome.reset_index()
lowIncome_rename=['NBHD_NAME','PCT_LOW_INCOME']
lowIncome.columns=lowIncome_rename
lowIncome=lowIncome.set_index('NBHD_NAME')


# In[341]:


NA=df_list[62]
NA=NA.drop('ID',axis=1).set_index('Variable').transpose()
NA=NA[['Total - Aboriginal identity for the population in private households - 25% sample data','  Non-Aboriginal identity']]
NA['NATIVE_AMERICA']=NA['Total - Aboriginal identity for the population in private households - 25% sample data']-NA['  Non-Aboriginal identity']
population=df_list[65]
population=population.drop('ID',axis=1).set_index('Variable').transpose()
population=population[['Total - Visible minority for the population in private households - 25% sample data',
                                                       '  Total visible minority population',
                                                                           '    South Asian',
                                                                               '    Chinese',
                                                                                 '    Black',
                                                                              '    Filipino',
                                                                        '    Latin American',
                                                                                  '    Arab',
                                                                       '    Southeast Asian',
                                                                            '    West Asian',
                                                                                '    Korean',
                                                                              '    Japanese',
                                                              '    Visible minority, n.i.e.',
                                                           '    Multiple visible minorities',
                                                                  '  Not a visible minority',]]
population['ASIAN']=population['    South Asian']+population['    Chinese']+population['    Filipino']+population['    Southeast Asian']+population['    West Asian']+population['    Korean']+population['    Japanese']
population['WHITE']=population['  Not a visible minority']
population['OTHER']=population['    Visible minority, n.i.e.']+population['    Multiple visible minorities']
population['TOTAL']=population['Total - Visible minority for the population in private households - 25% sample data']
population['HISPANIC']=population['    Latin American']
population['BLACK']=population['    Black']
population=population[['ASIAN', 'WHITE', 'OTHER', 'TOTAL',
       'HISPANIC', 'BLACK']]
population['NATIVE_AMERICA']=NA[['NATIVE_AMERICA']]
population['PCT_HAWAIIANPI']=0

population['PCT_HISPANIC']=(population['HISPANIC']/population['TOTAL'])*100
population['PCT_WHITE']=(population['WHITE']/population['TOTAL'])*100
population['PCT_BLACK']=(population['BLACK']/population['TOTAL'])*100
population['PCT_NATIVEAM']=(population['NATIVE_AMERICA']/population['TOTAL'])*100
population['PCT_ASIAN']=(population['ASIAN']/population['TOTAL'])*100
population['PCT_HAWAIIANPI']=(population['PCT_HAWAIIANPI']/population['TOTAL'])*100
population['PCT_OTHERRACE']=(population['OTHER']/population['TOTAL'])*100
population=population[['PCT_HISPANIC', 'PCT_WHITE',
       'PCT_BLACK', 'PCT_NATIVEAM', 'PCT_ASIAN', 'PCT_HAWAIIANPI',
       'PCT_OTHERRACE']]
population_rename=['NBHD_NAME','PCT_HISPANIC', 'PCT_WHITE',
       'PCT_BLACK', 'PCT_NATIVEAM', 'PCT_ASIAN', 'PCT_HAWAIIANPI',
       'PCT_OTHERRACE']
population=population.reset_index()
population.columns=population_rename
population=population.set_index('NBHD_NAME')


# In[343]:


Vstats= pd.concat([population, lowIncome,vIncome,medianAge,vage1],axis=1)


# In[346]:


Vstats=Vstats[['TTL_POPULATION_ALL', 'PCT_HISPANIC', 'PCT_WHITE', 'PCT_BLACK',
       'PCT_NATIVEAM', 'PCT_ASIAN', 'PCT_HAWAIIANPI', 'PCT_OTHERRACE', 'MALE',
       'FEMALE', 'AGE_10_TO_19', 'AGE_20_TO_29', 'AGE_30_TO_39',
       'AGE_40_TO_49', 'AGE_50_TO_59', 'AGE_60_OVER','MEDIAN_AGE_ALL', 'MEDIAN_AGE_MALE', 'MEDIAN_AGE_FEMALE',
        'PER_CAPITA_INCOME','PCT_LOW_INCOME']]


# In[324]:


# Dstats['PCT_LOW_INCOME']=Dstats['PCT_POVERTY']
Dstats=Dstats[['TTL_POPULATION_ALL', 'PCT_HISPANIC', 'PCT_WHITE', 'PCT_BLACK',
       'PCT_NATIVEAM', 'PCT_ASIAN', 'PCT_HAWAIIANPI', 'PCT_OTHERRACE', 'MALE',
       'FEMALE', 'AGE_10_TO_19', 'AGE_20_TO_29', 'AGE_30_TO_39',
       'AGE_40_TO_49', 'AGE_50_TO_59', 'AGE_60_OVER','MEDIAN_AGE_ALL', 'MEDIAN_AGE_MALE', 'MEDIAN_AGE_FEMALE',
        'PER_CAPITA_INCOME','PCT_LOW_INCOME']]


# In[350]:


nhbdStats=Vstats.append(Dstats)
nhbdStats=nhbdStats.reset_index()
nhbdStats


# In[352]:


## nhbdStats.to_csv("C:\\Users\\zemdy\\Documents\\csi4142\\Project\\" + "nhbdStats.csv", encoding='utf-8', index=False)


# In[ ]:




