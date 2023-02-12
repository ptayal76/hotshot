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
app.post('/login', async (req, res) => {
  const user = new User(req.body);
  user.save();
  jwt.sign(
    { isowner: false, id: user._id },
    process.env.JWT_SEC,
    (err, token) => {
      res.header('token', `${token}`);
      return res.json(user);
    }
  );
});

app.use(restaurantRoute);
app.use(dishRoute);
app.use(orderRoute);
app.use(stationaryRoutes);
app.use(otherShopRoutes);

app.listen(process.env.PORT || 8080, () => {
  console.log('Backend server is running fine!');
});
