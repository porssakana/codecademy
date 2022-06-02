'''Classification
In this project, you will use a dataset (https://www.kaggle.com/datasets/andrewmvd/heart-failure-clinical-data) to predict the survival of patients with heart failure from serum creatinine and ejection fraction, and other factors such as age, anemia, diabetes, and so on.'''

import pandas as pd
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.model_selection import train_test_split
from collections import Counter
from sklearn.compose import ColumnTransformer
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, InputLayer
from sklearn.metrics import classification_report
from tensorflow.keras.utils import to_categorical
import numpy as np

# 1. LOADING DATA
# loading data into data frame
df = pd.read_csv('heart_failure.csv')

# checking columns
print("###############  Checking Columns  ###############\n")
df.info()
print("###############  End Checking Columns  ###############\n")

# print class distribution of death_event
print("###############  Printing Class Distribution of death_event  ###############\n")
print(Counter(df['death_event']))
print("###############  End Printing  ###############\n")
 
# extract death_event labels
y = df['death_event']

# extract features 
x = df[['age','anaemia','creatinine_phosphokinase','diabetes','ejection_fraction','high_blood_pressure','platelets','serum_creatinine','serum_sodium','sex','smoking','time']]

# 2. DATA PREPROCESSING
# convert categorical features o one-hot encoding vectors
x = pd.get_dummies(x)

# train/test data split using stadard 420 parameters
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.33, random_state=42)

# scaling numeric features in the dataset using ColumnTransformer and  StandardScaler
ct = ColumnTransformer([("numeric", StandardScaler(), ['age','creatinine_phosphokinase','ejection_fraction','platelets','serum_creatinine','serum_sodium','time'])])

x_train = ct.fit_transform(x_train)
x_test = ct.transform(x_test)

# 3. PREPARE LABELS
le = LabelEncoder()

# fitting to the training labels while converting the training labels according to the trained encoder
y_train = le.fit_transform(y_train.astype(str))
y_test = le.transform(y_test.astype(str))

# transform the encoded training labels y_train into a binary vector
y_train = to_categorical(y_train)
y_test = to_categorical(y_test)

# 4. DESIGNING MODEL
model = Sequential()
# creating input layer
model.add(InputLayer(input_shape=(x_train.shape[1],)))
# creating hidden layer
model.add(Dense(12, activation='relu'))
# creating output layer
model.add(Dense(2, activation='softmax'))
# compiling model with given parameters
model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])

# 5. TRAINING
model.fit(x_train, y_train, epochs=100, batch_size=16, verbose=1)
loss, acc = model.evaluate(x_test, y_test, verbose=0)
print("\n################# Evaluation Results: #################")
print("Loss", loss, "Accuracy:", acc)

# 6. REPORTING
# making predictions for the test data with the trained model
y_estimate = model.predict(x_test, verbose=0)

# using argmax to select the indices of the true classes for each label encoding in y_estimate
y_estimate = np.argmax(y_estimate, axis=1)
y_true = np.argmax(y_test, axis=1)

# printing additional parameters (e.g. F1-score)
print("\n Additional metrics:")
print(classification_report(y_true, y_estimate))
