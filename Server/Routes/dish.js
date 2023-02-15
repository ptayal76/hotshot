//Dish Routes
const Dish = require('../Models/Dish');
const {
    verifyToken,
    authenticateOwner,
    authorizeOwner,
} = require('../Middlewares/verifyToken');
const Restaurant=require("../Models/Restaurant")
const Owner=Restaurant
const multer = require('multer');

const router = require('express').Router();

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

//GET ALL DISHES
router.get('/food/dish', async (req, res) => {
    try {
        var obj={};
        if(req.query.category)obj.category=req.query.category;
        if(req.query.price)obj.price={$lte:req.query.price };
        const dishes = await Dish.find(obj);
        res.status(200).json(dishes);
    } catch (err) {
        res.status(400).json(err);
    }
})

//GET DISH BY ID
router.get('/food/dish/:dishId', async (req, res) => {
    try {
        const id = req.params.dishId;
        const dish = await Dish.findById(id);
        
        res.status(200).json(dish);
    } catch (err) {
        
        res.status(400).json(err);
    }
})

//CREATE A DISH
router.post('/food/dish', upload.single('pic'), verifyToken, authenticateOwner, async (req, res) => {
    try {
        const newDish = new Dish(req.body);
        if(req.file)
        {
            newDish.pic.data = req.file.buffer;
            newDish.pic.contentType = req.file.mimetype;
        }
        newDish.Rest_Id = req.restaurant;
        const savedDish = await newDish.save();
        const restaurant = await Owner.findById(req.restaurant);
        restaurant.menu.push(savedDish);
        await restaurant.save();
        res.status(200).json(savedDish);
    } catch (err) {
        res.status(500).json(err);
    }
})

//UPDATE A DISH
router.put('/food/dish/:dishId', verifyToken, authenticateOwner, async (req, res) => {
    try {
        const dish = await Dish.findByIdAndUpdate(req.params.dishId, req.body);
        if (dish.Rest_Id == req.restaurant) {
            res.status(200).json(dish);
        }
        else {
            res.sendStatus(400);
        }
    } catch (err) {
        res.status(403).json(err);
    }
})

//DELETE A DISH
router.delete('/food/dish/:dish_id', verifyToken, authenticateOwner, async (req, res) => {
    try {
        const dish = await Dish.findById(req.params.dish_id);
        if (dish && dish.Rest_Id == req.restaurant) {
            await Dish.findByIdAndDelete(req.params.dish_id);
            res.status(200).json(dish);
        }
        else {
            res.sendStatus(400);
        }
    } catch (err) {
        res.status(403).json(err);
    }
})

module.exports = router;