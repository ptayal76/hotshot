//Stationary Order routes
const StatOrder = require('../Models/StatOrder');
const Razorpay = require('razorpay');
const mongoose = require('mongoose');
const Order = StatOrder;
const Stationary = require("../Models/Stationary");
const multer = require('multer');
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });
const {
    verifyToken,
    authenticateOwner,
    authenticateUser,
    authorizeOwner,
    authorizeUser,
    restOrder,
    authenticate,
    authenticateStationaryOwner
} = require('../Middlewares/verifyToken');
const jwt = require('jsonwebtoken');
const router = require('express').Router();
const jimp = require('jimp');
const fs = require('fs');
const qrCodeReader = require('qrcode-reader');
const qr = require('qrcode');

//GET ALL ORDERS
router.get("/stationary/order", verifyToken, authenticate, async (req, res) => {
    if (req.isowner) {
        const obj = { stationaryId: req.restaurant };
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
})

//GET ORDERS BY SHOP ID
router.get("/stationary/order/:orderId", verifyToken, authenticate, async (req, res) => {
    const order = await Order.findById(req.params.orderId);
    if (!order) {
        return res.status(400).json('Wrong orderId');
    }
    if (req.isowner) {
        if (req.restaurant == order.stationaryId) {
            return res.status(200).json(order);
        }
        else {
            return res.status(403).json({ message: "Not Authenticated" });
        }
    }
    else {
        if (req.user == order.user_id) {
            return res.status(200).json(order);
        }
        else {
            return res.status(403).json({ message: "Not Authenticated" });
        }
    }
})

//CREATE QR FOR USER
router.get("/stationary/order/qr/:orderId", async (req, res, next) => {
    try {
        const orderid = req.params.orderId;
        let data = { orderid };
        let stringdata = JSON.stringify(data);
        qr.toFile('qr1.png', stringdata, function (err, code) {
            if (err) {
                console.log(err);
            } else {
                const promise = fs.promises.readFile('./qr1.png');
                Promise.resolve(promise).then(function (buffer) {
                    const stringdata = JSON.stringify(buffer);
                    return res.status(200).json(buffer);
                })
            }
        })
    }
    catch (err) {
        return res.status(400).json(err);
    }
})

//CREATING ORDER
router.post('/stationary/order/:statId', upload.single('pic'), verifyToken, authenticateUser, async (req, res) => {
    try {
        var today = new Date();
        const newOrder = new Order({ stationaryId: mongoose.Types.ObjectId(req.params.statId), user_id: mongoose.Types.ObjectId(req.user), timeOfOrder: `${today.getFullYear()} ${today.getMonth() + 1} ${today.getDate()}`, Order_status: 'paymentPending', category: req.body.category, numberOfCopies: req.body.numberOfCopies, BothSides: req.body.BothSides, Orientation: req.body.Orientation, total: req.body.total })
        if (req.file) {
            newOrder.img.data = req.file.buffer;
            newOrder.img.contentType = req.file.mimetype;
        }
        await newOrder.save();
        return res.status(200).json(newOrder);
    } catch (err) {
        return res.status(500).json(err);
    }
});

//ACCEPTING THE ORDER
router.put('/stationary/order/accept/:orderid', verifyToken, authenticateStationaryOwner, async (req, res) => {
    try {
        const order = await Order.findById(req.params.orderid);
        if (!order) {
            return res.status(400).json('Wrong OrderId');
        }
        if (req.restaurant == order.stationaryId) {
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
router.put('/stationary/order/reject/:orderid', verifyToken, authenticateStationaryOwner, async (req, res) => {
    try {
        const order = await Order.findById(req.params.orderid);
        if (!order) {
            return res.status(400).json('Wrong OrderId');
        }
        if (req.restaurant == order.stationaryId) {
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
router.put('/stationary/order/complete/:orderid', async (req, res) => {
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
router.delete("/stationary/order/:orderId", verifyToken, authenticateUser, async (req, res) => {
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
    if (!order) {
        return res.status(400).json('Wrong OrderId');
    }
    const stationary = await Stationary.findById(order.stationaryId);
    if (order.user_id != req.user) {
        return res.status(403).json({ message: "you are not authenticated" });
    }
    const razorpayInstance = new Razorpay({
        key_id: stationary.razorpayCredKey_id || process.env.RZP_KEY_ID,
        key_secret: stationary.razorpayCredKeySecret || process.env.RZP_SEC_KEY
    })
    razorpayInstance.orders.create({ amount: order.total * 100, currency: "INR" }, (err, result) => {
        if (err) {
            return res.status(400).send(err.message);
        }
        else {
            return res.status(200).json({ orderid: result.id, keyid: stationary.razorpayCred.Key_id });
        }
    })
})

//AFTER PAYMENT IS DONE
router.put("/stationary/order/acknowledge/:orderId", async (req, res) => {
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

