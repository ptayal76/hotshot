//Dish Routes
const Dish = require('../Models/Dish');
const {
    verifyToken,
    authenticateOwner,
    authorizeOwner,
} = require('../Middlewares/verifyToken');
const Restaurant = require("../Models/Restaurant")
const Owner = Restaurant
const multer = require('multer');

const router = require('express').Router();

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });
const cloudinary = require("cloudinary");
const streamifier = require('streamifier');
//GET ALL DISHES
router.get('/food/dish', async (req, res) => {
    try {
        var obj = {};
        if (req.query.category) obj.category = req.query.category;
        if (req.query.price) obj.price = { $lte: req.query.price };
        if (req.query.suggestedTime) obj.suggestedTime = req.query.suggestedTime;
        const dishes = await Dish.find(obj);
        return res.status(200).json(dishes);
    } catch (err) {
        return res.status(400).json(err);
    }
})

//GET DISH BY ID
router.get('/food/dish/:dishId', async (req, res) => {
    try {
        const id = req.params.dishId;
        const dish = await Dish.findById(id);
        if (!dish) {
            return res.status(400).json('No dish by this ID exists!');
        }
        return res.status(200).json(dish);
    } catch (err) {
        res.status(400).json(err);
    }
})

//CREATE A DISH
router.post('/food/dish', upload.single('pic'), verifyToken, authenticateOwner, async (req, res) => {
    try {
        // if (req.file) {
        //     console.log("here11111");
        //     let cld_upload_stream = cloudinary.uploader.upload_stream(
              
        //       function( result,error) {
        //           restaurant.pic = result.secure_url
        //           existingRest = restaurant;
        //           restaurant.save();
        //           jwt.sign(
        //             { isowner: true, id: existingRest._id },
        //             process.env.JWT_SEC,
        //             (err, token) => {
        //               console.log("here222")
        //               console.log(token);
        //               res.header('token', `${token}`);
        //               return res.json(existingRest);
        //             }
        //           );
        //       }
        //       );
          
        //    streamifier.createReadStream(req.file.buffer).pipe(cld_upload_stream);
    
        //   }
          
        
        const newDish = new Dish(req.body);
            let cld_upload_stream = cloudinary.uploader.upload_stream(
          
                 async function (result,error){
                    newDish.pic = result.secure_url
                    newDish.Rest_Id = req.restaurant;
                    
                     await newDish.save();
                    const restaurant = await Owner.findById(req.restaurant);
                    restaurant.menu.push(newDish);
                    await restaurant.save();
                    return res.status(200).json(newDish);
                }
            );
             streamifier.createReadStream(req.file.buffer).pipe(cld_upload_stream);
        
        
        
        
            // newDish.Rest_Id = req.restaurant;
            //         const savedDish = await newDish.save();
            //         const restaurant = await Owner.findById(req.restaurant);
            //         restaurant.menu.push(savedDish);
                    
            //         await restaurant.save();
             
        
        

    } catch (err) {
        
        return res.status(500).json(err.message);
    }
})

//UPDATE A DISH
router.put('/food/dish/:dishId', verifyToken, authenticateOwner, async (req, res) => {
    try {
        console.log(req.body);
        const dish = await Dish.findById(req.params.dishId)
        if (!dish) {
            return res.status(400).json('Wrong DishId');
        }
        if (dish.Rest_Id == req.restaurant) {
            if (dish.InStock) {
                dish.InStock = false;
            }
            else {
                dish.InStock = true;
            }
            await dish.save();
            return res.status(200).json(dish);
        }
        else {
            return res.status(400).json('Wrong restaurant!');
        }
    } catch (err) {
        res.status(403).json(err);
    }
})

//DELETE A DISH
router.delete('/food/dish/:dish_id', verifyToken, authenticateOwner, async (req, res) => {
    try {
        const dish = await Dish.findById(req.params.dish_id);
        if (!dish) {
            return res.status(400).json('Wrong DishId');
        }
        if (dish && dish.Rest_Id == req.restaurant) {
            await Dish.findByIdAndDelete(req.params.dish_id);
            return res.status(200).json(dish);
        }
        else {
            return res.status(400).json("Couldn't delete dish!");
        }
    } catch (err) {
        res.status(403).json(err);
    }
})

module.exports = router;