const mongoose = require('mongoose');
const Restaurant=require('./Restaurant');
const Dish=require('./Dish');
const User=require('./User');
const schema = mongoose.Schema;

const order = new schema({
    restaurant_id: {
        type: mongoose.Schema.Types.ObjectId, ref: `Restaurant`,
    },
    user_id: { type: mongoose.Schema.Types.ObjectId, ref: `User` },
   items: [
        {
           type:mongoose.Schema.Types.ObjectId, ref: `Dish`
        }
    ]
    ,
    total: {
        type: Number,
        default: 0
    },
    timeOfOrder: {
        type: Date
    },
    category: {
        type: String
    },
    Order_status: {
        type:String,
        enum: ['ready', 'completed', 'rejected', 'paymentPending','responsePending','accepted']
    },
    razorpayCred:{
        Key_id:{
            type:String
        },
        KeySecret:{
            type:String
        }

    }
})
module.exports= mongoose.model('Order', order);