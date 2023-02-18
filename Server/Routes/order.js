//Order routes
const RestOrder = require('../Models/RestOrder');
const Dish = require("../Models/Dish");
const Razorpay = require('razorpay');
const mongoose = require('mongoose');
const Order = RestOrder;
const Restaurant = require("../Models/Restaurant");
const cloudinary = require("cloudinary");
const streamifier = require('streamifier');
const {
    verifyToken,
    authenticateOwner,
    authenticateUser,
    authorizeOwner,
    authorizeUser,
    restOrder,
    authenticate
} = require('../Middlewares/verifyToken');
const jwt = require('jsonwebtoken');
const router = require('express').Router();
const jimp = require('jimp');
const fs = require('fs');
const qrCodeReader = require('qrcode-reader');
const qr = require('qrcode');
cloudinary.config({
    cloud_name: 'dmuviaz8x',
    api_key: 232983377535948,
    api_secret: 'eGv35fpj-wodC6lw15MhBHvDb3M',
  });

//GET ALL ORDERS
router.get("/food/order", verifyToken, authenticate, async (req, res) => {
    try {
        if (req.isowner) {
            const obj = { restaurant_id: req.restaurant };
            if (req.query.status) {
                obj.Order_status = req.query.status;
            }
            const orders = await Order.find(obj);
            return res.status(200).json(orders);
        } else {
            const obj = { user_id: req.user };
            if (req.query.status) {
                obj.Order_status = req.query.status;
            }
            const orders = await Order.find(obj);
            return res.status(200).json(orders);
        }
    } catch (err) {
        return res.status(400).json(err);
    }
})

//GET ORDERS BY RESTID
router.get("/food/order/:orderId", verifyToken, authenticate, async (req, res) => {
    try {
        const order = await Order.findById(req.params.orderId);
        if (req.isowner) {
            if (req.restaurant == order.restaurant_id) {
                if (!order) {
                    return res.status(400).json('No order by this ID!');
                }
                return res.status(200).json(order);
            }
            else {
                return res.status(403).json({ message: "Not Authenticated" });
            }
        }
        else {
            if (req.user == order.user_id) {
                if (!order) {
                    return res.status(400).json('No order by this ID!');
                }
                return res.status(200).json(order);
            }
            else {
                return res.status(403).json({ message: "Not Authenticated" });
            }
        }
    } catch (err) {
        res.status(400).json(err);
    }
})


//CREATE QR FOR USER
router.get("/food/order/qr/:orderId", async (req, res, next) => {
    try {
        const orderid = req.params.orderId;
        let data = { orderid };
        let stringdata = JSON.stringify(data);
        qr.toFile('qr1.png', stringdata, function (err, code) {
            if (err) {
                console.log(err);
            } else {
                const promise = fs.promises.readFile('./qr1.png');
                promise.then(function (buffer) {
                    const stringdata = JSON.stringify(buffer);
                    return res.status(200).json(buffer);
                })
            }
        })
    }
    catch (err) {
        res.status(400).json(err);
    }
})

//ADDING ORDER
router.post('/food/order/add/:dishId', verifyToken, authenticateUser, async (req, res) => {
    try {
        const dish = await Dish.findById(req.params.dishId);
        const order = await Order.find({ restaurant_id: dish.Rest_Id, user_id: mongoose.Types.ObjectId(req.user), Order_status: 'paymentPending' });
        if (order.length) {
            order[0].items.push(req.params.dishId);
            order[0].total = order[0].total + dish.price;
            await order[0].save();
            return res.status(200).json(order[0]);
        }
        else {
            var today = new Date();
            const newOrder = new Order({ restaurant_id: dish.Rest_Id, user_id: req.user, items: [req.params.dishId], total: dish.price, timeOfOrder: `${today.getFullYear()} ${today.getMonth() + 1} ${today.getDate()}`, Order_status: 'paymentPending' });
            await newOrder.save()
            return res.status(200).json(newOrder);
        }
    } catch (err) {
        res.status(500).json(err);
    }
});

//REMOVING THE ITEM
router.post('/food/order/remove/:dishId', verifyToken, authenticateUser, async (req, res) => {
    try {
        const dish = await Dish.findById(req.params.dishId);
        const order = await Order.find({ restaurant_id: dish.Rest_Id, user_id: mongoose.Types.ObjectId(req.user), Order_status: 'paymentPending' });
        if (order.length) {
            const index = order[0].items.indexOf(req.params.dishId);
            if (index > -1) {
                order[0].items.splice(index, 1); // 2nd parameter means remove one item only
                order[0].total = order[0].total - dish.price;
                if (order[0].items.length == 0) {
                    await Order.findByIdAndDelete(order[0]._id)
                }
            }
            await order[0].save();
            return res.status(200).json(order[0]);
        }
    } catch (err) {
        res.status(500).json(err);
    }
});

//ACCEPTING THE ORDER
router.put('/food/rest/accept/:orderid', verifyToken, authenticateOwner, async (req, res) => {
    try {
        const order = await Order.findById(req.params.orderid);
        if (!order) {
            return res.status(400).json('Wrong orderId!');
        }
        if (req.restaurant == order.restaurant_id) {
            order.Order_status = 'accepted';
            await order.save();
            return res.status(200).send("Order Accepted");
        }
        else {
            return res.status(403).json({ message: "not authorized" });
        }
    }
    catch (error) {
        return res.status(402).send(error.message)
    }
})

//REJECTING THE ORDER
router.put('/food/rest/reject/:orderid', verifyToken, authenticateOwner, async (req, res) => {
    try {
        const order = await Order.findById(req.params.orderid);
        if (!order) {
            return res.status.json('Wrong OrderId');
        }
        if (req.restaurant == order.restaurant_id) {
            order.Order_status = 'rejected';
            await order.save();
            const razorpayInstance = new Razorpay({
                key_id: req.restaurant.razorpayCred.Key_id || process.env.RZP_KEY_ID,
                key_secret: req.restaurant.razorpayCred.KeySecret || process.env.RZP_SEC_KEY
            })
            razorpayInstance.payments.refund(paymentId, {
                "speed": "optimum",
            })
            return res.status(200).send("Order Rejected");
        }
        else {
            return res.status(403).json({ message: "not authorized" });
        }
    }
    catch (error) {
        return res.status(402).send(error.message)
    }
})

//COMPLETING THE ORDER
router.put('/food/rest/complete/:orderid', async (req, res) => {
    try {
        const order = await Order.findById(req.params.orderid);
        if (!order) {
            return res.status(400).json('Wrong OrderId');
        }
        order.Order_status = 'completed';
        await order.save();
        return res.status(200).json(order);
    }
    catch (error) {
        return res.status(402).send(error.message)
    }
})

//DELETING AN ORDER
router.delete("/food/order/:orderId", verifyToken, authenticateUser, async (req, res) => {
    const order = await Order.findById(req.params.orderId);
    if (!order) {
        return res.status(400).json('Wrong OrderId');
    }
    if (order.user_id == req.user) {
        await Order.findByIdAndDelete(req.params.orderId);
        return res.status(200).json({ message: "Order has been deleted!" });
    }
    else {
        return res.status(403).send("Not Authorized to delete this order");
    }
})


//PAYMENT
router.put("/food/order/checkout/:orderId", verifyToken, authenticateUser, async (req, res) => {
    const order = await Order.findById(req.params.orderId);
    const restaurant = await Restaurant.findById(order.restaurant_id);
    if (order.user_id != req.user) {
        return res.status(403).json({ message: "you are not authenticated" });
    }
    const razorpayInstance = new Razorpay({
        key_id: restaurant.razorpayCredKey_id || process.env.RZP_KEY_ID,
        key_secret: restaurant.razorpayCredKeySecret || process.env.RZP_SEC_KEY
    })
    razorpayInstance.orders.create({ amount: order.total * 100, currency: "INR" }, (err, result) => {
        if (err) {
            return res.status(400).send(err.message);
        }
        else {
            console.log(result);
            return res.status(200).json({ orderid: result.id, keyid: restaurant.razorpayCredKey_id });
        }
    })
})

//ACKNOWLEDGE A PAYMENT
router.put("/food/order/acknowledge/:orderId", async (req, res) => {
    try {
        const order = await Order.findById(req.params.orderId);
        if (!order) {
            return res.status(400).json('Wrong OrderId');
        }
        order.paymentId = req.body.razorpay_payment_id;
        order.Order_status = 'responsePending';
        order.save();
        res.status(200).send({ message: "Success" });
    }
    catch (e) {
        console.log(e.message)
        return res.status(400).json({ message: "error" });
    }
})

module.exports = router;
