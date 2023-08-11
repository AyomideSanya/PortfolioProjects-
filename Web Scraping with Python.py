#!/usr/bin/env python
# coding: utf-8

# In[1]:


#import Beautifulsoup and request

from bs4 import BeautifulSoup
import requests


# In[2]:


#input the web url

url="https://en.wikipedia.org/wiki/List_of_largest_financial_services_companies_by_revenue"

page = requests.get(url)

soup = BeautifulSoup(page.text, "html")


# In[3]:


print(soup)


# In[4]:


#finding the table on the page

table = soup.find_all('table')[0]


# In[5]:


print(table)


# In[6]:


#finding the Headers 1

table.find_all('th')[1:7]


# In[7]:


#finding the Headers 2(you can use the first or the second both works but i recommend the second )

world_title=soup.find_all('th')[1:7]

world_title


# In[ ]:





# In[8]:


#using for loop to get the header text

world_table_title = [title.text.strip() for title in world_title]

world_table_title


# In[9]:


#import pandas

import pandas as pd


# In[10]:


#create a dataframe and adding the headers

df=pd.DataFrame(columns= world_table_title)

df


# In[11]:


column_data= table.find_all('tr')


# In[12]:


for row in column_data[1:]:
    row_data = row.find_all('td')
    single_row_data= [data.text.strip() for data in row_data]
    
    lenght=len(df)
    df.loc[lenght] = single_row_data
    


# In[17]:


df.head(49)


# In[18]:


df.to_csv(r'C:\Users\HP\Desktop\Python project\Largest Companies by Revenue 2021.xlsx')


# In[ ]:




