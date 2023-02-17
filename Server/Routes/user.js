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
router.put('/food/user/rest/:restId', verifyToken, authenticateUser, async (req, res) => {
    try {
        const id = req.params.restId;
        const restaurant = await Restaurant.findById(id);
        if(!restaurant){
            return res.status(400).json('Wrong RestaurantId');
        }
        const user = await User.findById(req.user);
        user.favRest.push(restaurant);
        await user.save();
        return res.status(200).json('Added to favorites!');
    } catch (err) {
        return res.status(400).send(err.message);
    }
})

//LOGIN OR SIGNUP
router.post('/login', async (req, res) => {
    try {
        var existingUser = await User.findOne({ email: req.body.email });
        if (!existingUser) {
            const user = new User(req.body);
            existingUser = user;
            user.save();
        }
        jwt.sign(
            { isowner: false, id: existingUser._id },
            process.env.JWT_SEC,
            (err, token) => {
                res.header('token', `${token}`);
                return res.json(existingUser);
            }
        );
    } catch (err) {
        return res.status(500).json(err);
    }
})

module.exports = router;