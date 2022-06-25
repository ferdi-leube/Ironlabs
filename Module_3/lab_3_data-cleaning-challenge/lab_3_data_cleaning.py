# -*- coding: utf-8 -*-
"""
Created on Tue Jun 21 10:29:23 2022

@author: leube
"""

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

data = pd.read_csv(r"C:\Users\leube\Ironhack\cloned_labs\module_3\Lab_3_Data-Cleaning-Challenge\iris-data.csv")

data1 = data
data.info()
data.columns
data.shape

data.describe()

columns = list(data.columns)
columns.remove('class')

for x in columns: 
    sns.boxplot(y=x, data=data)
    plt.show()



def delete_outliers(column_list):
    for column in column_list:
        Q3 = data[column].quantile(0.75)
        Q1 = data[column].quantile(0.25)
        IQR = Q3 - Q1
        # cleaned = data[(data[column] > (Q3 + 1.5* IQR)) & (data[column] < (Q3 - 1.5* IQR))]
        data.drop(data[data[column] < (Q3 - 1.5* IQR)].index, inplace=True)
        data.drop(data[data[column] > (Q3 + 1.5* IQR)].index, inplace=True)
    return print('succes')
    



delete_outliers(columns)

data.shape

# clean classes

data['class'].unique()


data.replace({'Iris-setossa':'Iris-setosa','Iris-versicolor':'versicolor'},inplace=True)

data['class'].unique()
data.replace({'versicolor':'Iris-versicolor'}, inplace=True)
# null values

data.isnull().sum()/len(data)

# very low amount of null values, in this case okay to simply replace the, with average
# after taking care of outliers

from sklearn import preprocessing

from sklearn.preprocessing import LabelEncoder
le = LabelEncoder()
data['label'] = le.fit_transform(data['class'])

filter0 = data[data['class']=='Iris-setosa']
filter1 = data[data['class']=='Iris-virginica']
filter2 = data[data['class']=='Iris-versicolor']

avg0 = filter0['petal_width_cm'].mean()
avg1 = filter1['petal_width_cm'].mean()
avg2 = filter2['petal_width_cm'].mean()

avg0
avg1
avg2

sets = [filter0, filter1, filter2]
avgs = [avg0,avg1,avg2]

avgg = data['petal_width_cm'].mean()
    
classes = list(data['class'].unique())
classes
data 
for x in classes:
    ind = classes.index(x)
    print(ind)
    # data['petal_width_cm'][(np.isnan(data['petal_width_cm']))&(data['class]==x)] = avgs[ind]

    data.loc[(data['class']== x) &(data['petal_width_cm'].isnull() == True), 'petal_width_cm'] = avgs[ind]



data.head(10)
data1.head(10)


data.isnull().sum()/len(data)

data.to_csv(r"C:\Users\leube\Ironhack\cloned_labs\module_3\Lab_3_Data-Cleaning-Challenge\cleaned_data.csv")


# complete
    

