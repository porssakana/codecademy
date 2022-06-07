import tensorflow as tf
import app
from visualize import visualize_activations
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from sklearn.model_selection import train_test_split
from utils import load_galaxy_data

input_data, labels = load_galaxy_data()

# taking a look ath the input's shape
print(input_data.shape)
print(labels.shape)

# doing train/test split
x_train, x_test, y_train, y_test = train_test_split(input_data, labels, test_size=0.20, stratify=labels, shuffle=True, random_state=222)

# preprocess the input and normilize pixels
data_generator = ImageDataGenerator(rescale=1./255)

# creating iterators for arrays of input data
training_iterator = data_generator.flow(x_train, y_train,batch_size=5)
validation_iterator = data_generator.flow(x_test, y_test, batch_size=5)

# creating model
model = tf.keras.Sequential()
# the images are 128 pixels tall, 128 pixels wide, and have 3 channels RGB, hence the shape must be (128, 128, 3)
model.add(tf.keras.Input(shape=(128, 128, 3)))
# adding more layers to the architecture: two convolutional layers, interspersed with max pooling layers, followed by two dense layers
model.add(tf.keras.layers.Conv2D(8, 3, strides=2, activation="relu")) 
model.add(tf.keras.layers.MaxPooling2D(
    pool_size=(2, 2), strides=(2,2)))
model.add(tf.keras.layers.Conv2D(8, 3, strides=2, activation="relu")) 
model.add(tf.keras.layers.MaxPooling2D(
    pool_size=(2,2), strides=(2,2)))
model.add(tf.keras.layers.Flatten())
model.add(tf.keras.layers.Dense(16, activation="relu"))
model.add(tf.keras.layers.Dense(4, activation="softmax"))

# compiling model
model.compile(
    optimizer=tf.keras.optimizers.Adam(learning_rate=0.001),
    loss=tf.keras.losses.CategoricalCrossentropy(),
    metrics=[tf.keras.metrics.CategoricalAccuracy(),tf.keras.metrics.AUC()])

# training model
model.fit(
        training_iterator,
        steps_per_epoch=len(x_train)/5,
        epochs=8,
        validation_data=validation_iterator,
        validation_steps=len(x_test)/5)

# visualizing convo process
visualize_activations(model,validation_iterator)
