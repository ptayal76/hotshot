const express = require('express');
const jwt = require('jsonwebtoken');
const multer = require('multer');
const mongoose = require('mongoose');
const cloudinary = require("cloudinary");
const streamifier = require('streamifier');

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
const Order = require('../Models/RestOrder');

const router = express.Router();
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

cloudinary.config({
  cloud_name: process.env.CLOUDNAME||'dmuviaz8x',
  api_key: process.env.APIKEY||232983377535948,
  api_secret: process.env.APISECRET||'eGv35fpj-wodC6lw15MhBHvDb3M',
});

//GET ALL RESTAURANTS BY QUERY
router.get('/food/rest', async (req, res) => {
  try {
    var obj = {};
    if (req.query.status) obj.status = req.query.status
    if (req.query.rating) obj.rating = { $gte: req.query.rating }
    if (req.query.locationCategory) obj.locationCategory = req.query.locationCategory;
    if (req.query.name) {
      obj.restaurantName = {
        "$regex": `${req.query.name}`, "$options": 'i'
      }
    }
    const restaurants = await Restaurant.find(obj);
  
    return res.json(restaurants);
  } catch (err) {
    return res.status(400).send(err.message);
  }
});

//TOP PICKS
router.get('/food/rest/top', async (req, res) => {
  try {
    var mySort = { rating: -1 };
    const restaurants = await Restaurant.find().sort(mySort);
    const toprest = []
    for (let i = 0; i < 5; i++) {
      toprest.push(restaurants[i]);
    }
    return res.status(200).json(toprest);
  } catch (err) {
    return res.status(200).json(err);
  }
});

//GET A RESTAURANT BY ID
router.get('/food/rest/:restid', async (req, res) => {
  try {
    const id = req.params.restid;
    const restaurant = await Restaurant.findById(id);
    console.log(restaurant);
    if (!restaurant) {
      return res.status(400).json('Wrong RestId');
    }
    return res.json(restaurant);
  } catch (err) {
    return res.status(400).send(err.message);
  }
});

//CREATE A RESTAURANT
router.post('/food/rest', upload.single('pic'), async (req, res) => {
  try {
    var existingRest = await Restaurant.findOne({ email: req.body.email });
    if (!existingRest) {
      const restaurant = new Restaurant(req.body);
      if (req.file) {
        let cld_upload_stream = cloudinary.uploader.upload_stream(
          
          function( result,error) {
              restaurant.pic = result.secure_url
              existingRest = restaurant;
              restaurant.save();
              jwt.sign(
                { isowner: true, id: existingRest._id },
                process.env.JWT_SEC,
                (err, token) => {
                  res.header('token', `${token}`);
                  return res.json(existingRest);
                }
              );
          }
          );
      
       streamifier.createReadStream(req.file.buffer).pipe(cld_upload_stream);

      }
      
    }
    
  } catch (err) {
    return res.status(400).send(err.message);
  }
});

//LOGIN FOR RESTAURANT
router.post('/food/rest/login', async (req, res) => {
  try {
    const restaurant = await Restaurant.findOne({ email: req.body.email });
    if (!restaurant) {
      return res.status(403).json({ message: "You are not registered" });
    }
    else {
      jwt.sign(
        { isowner: true, id: restaurant._id },
        process.env.JWT_SEC,
        (err, token) => {
          res.header('token', `${token}`);
          return res.json(restaurant);
        }
      );
    }
  }
  catch (err) {
    res.status(403).send(err.message);
  }
})

//UPDATE A RESTAURANT BY ID
router.put('/food/rest/:restid', verifyToken, authenticateOwner, authorizeOwner, async (req, res) => {
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
});

//RATE A RESTAURANT
router.put('/food/rest/rate/:restid', verifyToken, authenticateUser, authorizeUser, async (req, res) => {
  try {
    const restaurant = await Restaurant.findById(req.params.restid);
    const user = await User.findById(req.user);
    var found = 0;
    for (let i = 0; i < restaurant.usersRated.length; i++) {
      if (restaurant.usersRated[i].id == user._id) {
        found = 1;
        restaurant.rating = (restaurant.rating * restaurant.usersRated.length - restaurant.usersRated[i].rate + req.body.rating) / restaurant.usersRated.length;
        restaurant.usersRated[i].rate = req.body.rating;
      }
    }
    if (!found) {
      restaurant.rating = (restaurant.rating * restaurant.usersRated.length + req.body.rating) / (restaurant.usersRated.length + 1);
      restaurant.usersRated.push({ id: user._id, rate: req.body.rating });
      restaurant.save();
      return res.status(200).json(restaurant);
    } else {
      return res.status(200).json('You have already rated!');
    }
  } catch (err) {
    return res.status(400).send(err.message);
  }
}
);

//DELETE A RESTAURANT
router.delete('/food/rest/:restid', verifyToken, authenticateOwner, authorizeOwner, async (req, res) => {
  try {
    await Restaurant.findByIdAndDelete(req.params.restid);
    return res.status(200).json('Restaurant has been deleted!');
  } catch (err) {
    return res.status(500).json(err);
  }
}
);

//BUSINESS INSIGHTS
router.get('/stats', verifyToken, authenticateOwner, async (req, res) => {
  const now = new Date();
  const lastWeekDate = new Date(now.getFullYear(), now.getMonth(), now.getDate() - 6);
  const RestId = new mongoose.Types.ObjectId(req.restaurant);
  try {
    const data = await Order.aggregate([
      { $match: { timeOfOrder: { $gte: lastWeekDate, $lte: now } } },
      {
        $match: { restaurant_id: RestId }
      },
      {
        $group: {
          _id: {
            year: { $year: "$timeOfOrder" },
            month: { $month: "$timeOfOrder" },
            day: { $dayOfMonth: "$timeOfOrder" }
          },
          total: { $sum: '$total' }
        }
      },
    ]);
    res.status(200).json(data);
  } catch (err) {
    res.status(500).json(err);
  }
})

module.exports = router;
