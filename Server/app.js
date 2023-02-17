// Creating an express app
const express = require('express');
const mongoose = require('mongoose');
const jwt = require('jsonwebtoken');
const app = express();
mongoose.set('strictQuery', false);

// Setting up dotenv for private/secure data
const dotenv = require('dotenv');
dotenv.config();

const User = require('./Models/User');

//Routers
const restaurantRoute = require('./Routes/restaurant');
const dishRoute = require('./Routes/dish');
const orderRoute = require('./Routes/order');
const stationaryRoutes = require('./Routes/stationary');
const otherShopRoutes = require('./Routes/otherShop');
const userRoutes = require('./Routes/user');
const orderStatRoutes = require('./Routes/statOrder');

//Node.js MongoDB connection
mongoose
  .connect(process.env.MONGO_URL)
  .then(() => {
    console.log('DB Connection Successful!');
  })
  .catch((err) => {
    console.log(err);
  });

app.use(express.json());
app.use(restaurantRoute);
app.use(dishRoute);
app.use(orderRoute);
app.use(stationaryRoutes);
app.use(otherShopRoutes);
app.use(userRoutes);
app.use(orderStatRoutes);

app.listen(process.env.PORT || 8080, () => {
  console.log('Backend server is running fine!');
});
