const express = require('express');
const jwt = require('jsonwebtoken');
const multer = require('multer');

//Restaurant routes
const Restaurant = require('../Models/Restaurant');
const {
  verifyToken,
  authenticateOwner,
  authorizeOwner,
  authenticateUser,
  authorizeUser,
  restOrder,
} = require('../Middlewares/verifyToken');
const User = require('../Models/User');

const router = express.Router();
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

//GET ALL RESTAURANTS
router.get('/food/rest', async (req, res) => {
  try {
    const restaurants = await Restaurant.find();
    return res.json(restaurants);
  } catch (err) {
    return res.status(400).send(err.message);
  }
});

//GET A RESTAURANT BY ID
router.get('/food/rest/:restid', async (req, res) => {
  try {
    const id = req.params.restid;
    const restaurant = await Restaurant.findById(id);
    return res.json(restaurant);
  } catch (err) {
    return res.status(400).send(err.message);
  }
});

//CREATE A RESTAURANT
router.post('/food/rest', upload.single('pic'), async (req, res) => {
  try {
    const restaurant = new Restaurant(req.body);
    restaurant.pic.data = req.file.buffer;
    restaurant.pic.contentType = req.file.mimetype;
    await restaurant.save();

    jwt.sign(
      { isowner: true, id: restaurant._id },
      process.env.JWT_SEC,
      (err, token) => {
        res.header('token', `${token}`);
        return res.json(restaurant);
      }
    );
  } catch (err) {
    return res.status(400).send(err.message);
  }
});

//UPDATE A RESTAURANT BY ID
router.put(
  '/food/rest/:restid',
  verifyToken,
  authenticateOwner,
  authorizeOwner,
  async (req, res) => {
    try {
      const restaurant = await Restaurant.findByIdAndUpdate(
        req.params.restid,
        req.body,
        { runValidators: true, new: true }
      );

      return res.json(restaurant);
    } catch (err) {
      return res.status(400).send(err.message);
    }
  }
);

// rate a restaurant
router.put(
  '/food/rest/rate/:restid',
  verifyToken,
  authenticateUser,
  authorizeUser,
  async (req, res) => {
    try {
      const restaurant = await Restaurant.findById(req.params.restid);
      const user = await User.findById(req.user);
      var found = 0;
      for (let i = 0; i < restaurant.usersRated.length; i++) {
        if (restaurant.usersRated[i].id == user._id) {
          found = 1;
          restaurant.rating =
            (restaurant.rating * restaurant.usersRated.length -
              restaurant.usersRated[i].rate +
              req.rating) /
            restaurant.usersRated.length;
          restaurant.usersRated[i].rate = req.rating;
        }
      }
      if (!found) {
        restaurant.rating =
          (restaurant.rating * restaurant.usersRated.length + req.rating) /
          (restaurant.usersRated.length + 1);
        restaurant.usersRated.push({ id: user._id, rate: req.rating });
      }
      restaurant.save();
    } catch (err) {
      return res.status(400).send(err.message);
    }
  }
);

//DELETE A RESTAURANT
router.delete(
  '/food/rest/:restid',
  verifyToken,
  authenticateOwner,
  authorizeOwner,
  async (req, res) => {
    try {
      await Restaurant.findByIdAndDelete(req.params.restid);
      return res.status(200).json('Restaurant has been deleted!');
    } catch (err) {
      return res.status(500).json(err);
    }
  }
);

module.exports = router;
