# -*- coding: utf-8 -*-
"""
Created on Sun Jul  3 20:20:26 2022

@author: leube
"""

from imblearn.under_sampling import NearMiss
from imblearn.pipeline import make_pipeline
from imblearn.metrics import classification_report_imbalanced

from pandas import read_csv # For dataframes
from pandas import DataFrame # For dataframes
from numpy import ravel # For matrices
import matplotlib.pyplot as plt # For plotting data
import seaborn as sns # For plotting data
from sklearn.model_selection import train_test_split # For train/test splits
from sklearn.neighbors import KNeighborsClassifier # The k-nearest neighbor classifier
from sklearn.feature_selection import VarianceThreshold # Feature selector
from sklearn.pipeline import Pipeline # For setting up pipeline
from sklearn.metrics import accuracy_score
# Various pre-processing steps
from sklearn.preprocessing import Normalizer, StandardScaler, MinMaxScaler, PowerTransformer, MaxAbsScaler, LabelEncoder
from sklearn.model_selection import GridSearchCV # For optimization
from sklearn import metrics
from sklearn.metrics import classification_report

import pandas as pd
import numpy as np

import seaborn as sns
import matplotlib.pyplot as plt

def generate_results(prediction, y_test, model, x_test):
    print('The accuracy of the Tree is', '{:.3f}'.format(metrics.accuracy_score(prediction,y_test)))
    print(classification_report(y_test,prediction))

    # matrix

    cm = metrics.plot_confusion_matrix(model, x_test, y_test,
                                 cmap=plt.cm.Blues,
                                 normalize=None)
    cm.ax_.set_title(f'{model} Confusion matrix, without normalization');

data = pd.read_csv(r"C:\Users\leube\Ironhack\cloned_labs\module_3\Lab_12_Imbalance\cleaned_data.csv")

X = data.drop(['isFraud','isFlaggedFraud'],axis=1)
y = data['isFraud']
x_train,x_test,y_train,y_test = train_test_split(X,y,test_size=0.2,random_state=42)


from sklearn.ensemble import AdaBoostClassifier
pipe = Pipeline([
('scaler', StandardScaler()),
('selector', VarianceThreshold()),
('classifier', AdaBoostClassifier())
])


# data seems to be too big, got a memory error, lets sample
datasam = data.sample(frac=0.2,random_state=42)

X = datasam.drop(['isFraud','isFlaggedFraud'],axis=1)
y = datasam['isFraud']
x_train,x_test,y_train,y_test = train_test_split(X,y,test_size=0.2,random_state=42)

# lets try again
pipe = make_pipeline(NearMiss(version=2),
                     StandardScaler(),
                     VarianceThreshold(),
                     AdaBoostClassifier()
                     )
pipe.fit(x_train, y_train)

predictions = pipe.predict(x_test)
generate_results(predictions,y_test,pipe,x_test)


# the f1 score is worse i thsi case, the recall fo fraudelent transactions has drastically
# imporoved to a 100%, meaning all frauds are being detected
# problem here --> 80% of non frauds are classified as fraus as well, if this would be
#  a samller proportion I'd say we are fine because we would rather want a fe falsly classified
# then many falsly not classified, but this proportion is definetly to big


# what happened here, maybe an overfitting lets compare results fro x train and x test

predictions = pipe.predict(x_test)
generate_results(predictions,y_test,pipe,x_test)

predictionstrain = pipe.predict(x_train)
generate_results(predictionstrain,y_train,pipe,x_train)



# results:
# no overfitting here, results are for both cases 'bad' in terms of the case described above
# danger of undersampling, model being too sensitive for minority group
    
    
# lets apply smote

from collections import Counter
from sklearn.datasets import make_classification
from imblearn.over_sampling import SMOTE 

sm = SMOTE(random_state=42)
x_res, y_res = sm.fit_resample(X, y)


x_train,x_test,y_train,y_test = train_test_split(x_res,y_res,test_size=0.2,random_state=42)


pipesmote = Pipeline([
('scaler', StandardScaler()),
('selector', VarianceThreshold()),
('classifier', AdaBoostClassifier())
])
    
pipesmote.fit(x_train,y_train)

predictions = pipe.predict(x_test)
generate_results(predictions,y_test,pipe,x_test)

# similar problem as above, the over or under sampling makes the model very sensitive
# to he characteristics of the frauds, therefor a high amount of regular transactions
# are clssified as fraudelent as well

# methods of under and over sampling come in handy or will work best, if characteristics between
# different labels are highly different from eachother and the reason why the models recall
# was low on all data was because it just focused its decision making too much on the
# majority group, the minorities characteristics just werent frequent enough to be taken 
# into account enough, for this scenario --> these methods work, here one must find
# a better solutionof adjusting the data or looking for further characteristics
# clearly defrentiating between fraud and not fraud

# maybe not taking out account names would ave made an difference, cant say from here
# but took step due to high cardinality and the amount of unique values in two further columns
# would have probably crashed my computer
    
    
    
    
