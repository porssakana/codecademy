import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.preprocessing import Normalizer
from sklearn.compose import ColumnTransformer
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import InputLayer
from tensorflow.keras.layers import Dense
from tensorflow.keras.optimizers import Adam

# creating dataframe
dataset = pd.read_csv('life_expectancy.csv')

# dropping irrelevant confusion
dataset = dataset.drop(["Country"], axis=1)

# split the data into labels and features
labels = dataset.iloc[:, -1]
features = dataset.iloc[:, 0:-1]

# convert categorical columns into numerical columns
features = pd.get_dummies(features)

# split data into training and test sets
features_train, features_test, labels_train, labels_test = train_test_split(features, labels, test_size = 0.30, random_state=25)

# list all of the numerical features in the dataset
numerical_features = features.select_dtypes(include=['float64', 'int64'])
numerical_columns = numerical_features.columns

# normalization/standardization
ct = ColumnTransformer([("only numeric", StandardScaler(), numerical_columns)], remainder='passthrough')

# fitting ct to training/test data and transforming 
features_train_scaled = ct.fit_transform(features_train)
features_test_scaled = ct.transform(features_test)

# building model
model = Sequential()

# creating input layer corresponding to number of features
input = InputLayer(input_shape = (features.shape[1], ))

# adding input layer to model
model.add(input)

# adding hidden layers with relu activation
model.add(Dense(64, activation='relu'))

# adding output layer
model.add(Dense(1))

# creating Adam optimizer
opt = Adam(learning_rate=0.01)

# compiling model
model.compile(loss='mse', metrics='mae', optimizer = opt)

# training model
model.fit(features_train_scaled, labels_train, epochs=40, batch_size=1, verbose=1)

# evaluate model
res_mse, res_mae = model.evaluate(features_test_scaled, labels_test, verbose = 0)
print("||||||||||||| Results |||||||||||||")
print(res_mse, res_mae)
