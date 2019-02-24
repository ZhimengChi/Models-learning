import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn import preprocessing
from sklearn.ensemble import RandomForestRegressor # random forest
from sklearn.pipeline import make_pipeline
from sklearn.model_selection import GridSearchCV # cross validation
from sklearn.metrics import mean_squared_error,r2_score # matrics
from sklearn.externals import joblib # Python pickle package, storing large numpy arrays

dataset_url = 'http://mlr.cs.umass.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv'
data = pd.read_csv(dataset_url, sep=';')

y=data.quality
X=data.drop('quality', axis=1)
X_train, X_test, y_train, y_test = train_test_split(X, y, 
                                                    test_size=0.2, 
                                                    random_state=123, 
                                                    stratify=y)

scaler=preprocessing.StandardScaler().fit(X_train)
X_train_scaled = scaler.transform(X_train)
X_test_scaled = scaler.transform(X_test)

# declare data preprocessing steps
pipeline = make_pipeline(preprocessing.StandardScaler(), 
                         RandomForestRegressor(n_estimators=100))

# declare hyperparameters to tune
hyperparameters= {'randomforestregressor__max_features': ['auto', 'sqrt', 'log2'],
'randomforestregressor__max_depth': [None,5,3,1]}

# cross-validation
clf = GridSearchCV(pipeline, hyperparameters, cv=10)
clf.fit(X_train, y_train)

# prediction result
y_pred = clf.predict(X_test)

# save for future use
joblib.dump(clf, 'rf_regressor.pkl')
clf2 = joblib.load('rf_regressor.pkl')
clf2.predict(X_test)