# -*- coding: utf-8 -*-
"""
Created on Thu Jun 30 18:40:56 2022

@author: leube
"""

import pandas as pd
import numpy as np

import nltk
from nltk.corpus import stopwords
from nltk.stem.wordnet import WordNetLemmatizer
from nltk.stem.porter import PorterStemmer
nltk.download('stopwords')
import re

data = pd.read_csv(r"C:\Users\leube\Downloads\Sentiment140.csv")
data = data.sample(n=50000, random_state=42)

data['text']

def clean_up_tokenize(text):
    """
    Cleans up numbers, URLs, and special characters from a string.

    Args:
        s: The string to be cleaned up.

    Returns:
        A string that has been cleaned up.
    
    
    """

    new = text.split(sep=' ')
    nolink = [x for x in new if x.startswith('http') == False]
    text = " ".join(nolink)
    text = re.sub(r"[^a-zA-Z]", " ", text)
    text = text.lower()
    return text.split()

def stem_and_lemmatize(words):
    """
    Perform stemming and lemmatization on a list of words.

    Args:
        l: A list of strings.

    Returns:
        A list of strings after being stemmed and lemmatized.
    """
    # Reduce words to their stems
    stemmed = [PorterStemmer().stem(w) for w in words]
    # Reduce words to their root form
    lemmed = [WordNetLemmatizer().lemmatize(w) for w in stemmed]
    return lemmed

def remove_stopwords(words):
    """
    Remove English stopwords from a list of strings.

    Args:
        l: A list of strings.

    Returns:
        A list of strings after stop words are removed.
    """
    words = [w for w in words if w not in stopwords.words("english")]
    # words = [w for w in words if len(w)>1]
    return words

list(data['text'])

data['text_processed'] = data['text'].apply(clean_up_tokenize)

data['text_processed'] = data['text_processed'].apply(stem_and_lemmatize)

data['text_processed']

data['text_processed'] = data['text_processed'].apply(remove_stopwords)

alllist = list(data['text_processed'])
alllist

words = [word for sublist in alllist for word in sublist]
words
import collections
import operator

c = collections.Counter(words)
c
sor = dict( sorted(c.items(), key=operator.itemgetter(1),reverse=True))
sor
first5000 = dict(list(sor.items())[:5000])

lis5000 = list(first5000.keys())
unique = set(lis5000)
tst = data.copy()
lis5000
tst2 = data.copy()
word1 = lis5000[0]
word1
tst2[word1] = 0
tst2.loc[tst2['text_processed'].contains(word1), word1] = 1

tst2[word1].value_counts()
listdic = []

tst3 = data.copy()


for word in unique:
    tst3[word] = 0

for word in unique:
    d = {}
    alll = list(tst2['text_processed'])
    for lis in alll:
        if word in lis:
            ind = alll.index(lis)
            tst3[word].iloc[ind] = 1
        else:
            continue

# check
tst3['becca'].value_counts()

# testing


tst3.columns
tst3.iloc['becca'][0]            

    
tst3['becca'].iloc[200] 


# result check
yo = list(tst3.columns)
yo
yo.remove('text_processed')

for yo in yo:
    print(yo)
    print(tst3[yo].unique())
    print('\n')

# worked

for x in yo[0:5]:
    tst3[x] = data[x]
    
for x in yo[0:5]:
    print(tst3[x].unique())

# values of target 0 and 4, lets change that to 0 and 1
tst3['target'] = np.where(tst3['target']==4,1,0)

tst3['target'].unique()

# lets drop unnecessary columns
tst4 = tst3.copy()
for x in list(tst4.columns)[1:7]:
    del tst4[x]
    
#check

list(tst4.columns)[:10]

tst4.info()

from sklearn.model_selection import train_test_split

tst5 = tst4.sample(n=35000, random_state=42)

X = tst5.drop('target',axis=1)
y = tst5['target']

X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.2,random_state=42)


from nltk import NaiveBayesClassifier

#from sklearn.decomposition import PCA

#X_try = X_train

#pca = PCA(n_components=2)
#components = pca.fit_transform(X_try)

# have to make tuples with row as first element and target as second

filter1 = tst5[tst5['target']==1]

filter0 = tst5[tst5['target']==0]

rows1 = []
for index, rows in filter1.iterrows():
    rowsyo1 = []
    for x in list(filter1.drop('target',axis=1).columns):
        rowsyo1.append(rows.x)
    
    rowsyo1.append(rows1)



# define function to make list with dictioary of rows and values and target tuples

def dict_for_nltk():
    finished_list = []
    for slicy in range(len(tst5)):
        d = {}
        for x in list(filter1.drop('target',axis=1).columns):
            d[x] = tst5[x].iloc[slicy]
        finished_list.append((d,tst5['target'].iloc[slicy]))
        
#experiments 

tst5['target'].iloc[200]
tst5['target'].iloc[0]
alltups = [()]
prepairedlist = []

classifier = NaiveBayesClassifier.train()

# call function

dict_for_nltk()


# result of this function will be a list of tuples containing a dictionary of words
# and their values as well as the target value, this would be the list split into
# train and test with sizes as wished and then inputted into the naivebayesclassifier

#  after complete training the Classifier would then be able to make predictions
# for dictionaries for each tweet containing of words and values (if in tweet or not)

# accuracy of model could be checked with test set

# link for detailed example:
    # https://www.nltk.org/book/ch06.html
    
    
# at this point I will stop with this lab, sadly my computer does not have the necessary
# capabilities of working with such a high amount of data and the performed calculations
















