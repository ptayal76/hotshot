//Order routes
const RestOrder = require('../Models/RestOrder');
const Dish = require("../Models/Dish");
const mongoose = require('mongoose');
const Order = RestOrder;
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

//GET ALL ORDERS
router.get("/food/order", verifyToken,authenticate, async (req, res) => {
    if (req.isowner) {
        const orders = await Order.find({ restaurant_id: req.restaurant });
        res.status(200).json(orders);
    } else {
        const orders = await Order.find({ user_id: req.user });
        res.status(200).json(orders);
    }
})

//CREATE QR FOR USER
router.post("/food/order/qr/:orderId", verifyToken, authenticateUser, async (req, res, next) => {
    try {
        const id = req.params.orderId;
        const order = await Order.findById(id);
        console.log(order);
        console.log(req.user, order.user_id);
        if (order.user_id == req.user) {
            //send qr
            console.log('here');
            let data = { order }
            let stringdata = JSON.stringify(data);
            
            qr.toFile('qr1.png', stringdata, function (err, code) {
                if (err) {
                    console.log(err);
                } else {
                    console.log('QR code generated!');
                }
            })
            res.status(200).json(order);
        }
        else {
            res.sendStatus(403);
        }
    } catch (err) {
        res.status(400).json(err);
    }
})

//GET ORDER BY QR ID(User side & restaurant side)(scan qr to get this order)(doubt)
router.get('/food/order/scanqr', verifyToken, authenticate, async (req, res) => {
    try {
        if (req.isowner) {
            const buffer = fs.readFileSync('./qr1.png');
            console.log('here');
            jimp.read(buffer, function (err, image) {
                if (err) {
                    console.log(err);
                }
                const qrCodeInstance = new qrCodeReader();
                qrCodeInstance.callback = function (err, value) {
                    if (err) {
                        console.log(err);
                    }
                    res.status(200).json(value.result);
                }
                qrCodeInstance.decode(image.bitmap);
            })
        }
        else {
            res.sendStatus(403);
        }
    } catch (err) {
        res.status(400).json(err);
    }
})

//CREATE ORDER
router.post('/food/order/:dishId', verifyToken, authenticateUser, async (req, res) => {
    try {
        const dish = await Dish.findById(req.params.dishId);
        const order = await Order.find({ restaurant_id: dish.Rest_Id, user_id: mongoose.Types.ObjectId(req.user), Order_status: 'responsePending' });
        if (order.length) {

            order[0].items.push(req.params.dishId);
            order[0].total = order[0].total + dish.price;
            await order[0].save();
            return res.status(200).json(order[0]);
        }
        else {

            var today = new Date();
            const newOrder = new Order({ restaurant_id: dish.Rest_Id, user_id: req.user, items: [req.params.dishId], total: dish.price, timeOfOrder: `${today.getFullYear()} ${today.getMonth() + 1} ${today.getDate()}`, Order_status: 'responsePending' });
            await newOrder.save()
            //payment gateway
            return res.status(200).json(newOrder);
        }

    } catch (err) {
        res.status(500).json(err);
    }
});

//ACCEPTING THE ORDER
router.put('/food/rest/accept/:orderid', verifyToken, authenticateOwner, async (req, res) => {
    try {
        const order = await Order.findById(req.params.orderid);
        if (req.restaurant == order.restaurant_id) {
            order.status = 'accepted';
            await order.save();
            res.status(200).send("Order Accepted");
        }
        else {
            res.status(403).json({ message: "not authorized" });
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
        if (req.restaurant == order.restaurant_id) {
            order.status = 'rejected';
            await order.save();
            res.status(200).send("Order Rejected");
            //refund gateway
        }
        else {
            res.status(403).json({ message: "not authorized" });
        }

    }
    catch (error) {

        return res.status(402).send(error.message)
    }
})

//DELETING AN ORDER
router.delete("/food/order/:orderId", verifyToken, authenticateUser, async (req, res) => {
    const order = await Order.findById(req.params.orderId);
    if (order.user_id == req.user) {
        await Order.findByIdAndDelete(req.params.orderId);
        return res.status(200).json({ message: "Order has been deleted!" });
    }
    else {
        res.status(403).send("Not Authorized to delete this order");
    }

})

module.exports = router;

