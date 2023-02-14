const express = require('express');
const jwt = require('jsonwebtoken');
const multer = require('multer');

//User routes
const User = require('../Models/User');
const Restaurant = require('../Models/Restaurant');
const {
    verifyToken,
    authenticateOwner,
    authorizeOwner,
    authenticateUser,
    authorizeUser,
    authenticate
} = require('../Middlewares/verifyToken');

const router = express.Router();
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

//ADDING RESTAURANT TO USER'S FAVS.
router.put('/food/user/rest/:restId', verifyToken, authenticateUser, async (req, res)  => {
    try{
        const id = req.params.restId;
        const restaurant = await Restaurant.findById(id);
        const user = await User.findById(req.user);
        user.favRest.push(restaurant);
        await user.save();
        res.status(200).json('Added to favorites!');
    } catch(err) {
        return res.status(400).send(err.message);
    }
})

module.exports = router;