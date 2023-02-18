const Dish = require('./Dish')
const mongoose = require('mongoose');
const schema = mongoose.Schema;

const restaurant = new schema({
    ownerName: {
        required: true,
        type: String
    },
    restaurantName: {
        required: true,
        type: String
    },
    phoneNumber: {
        required: true,
        type: String
    },
    email: {
        required: true,
        type: String,
    },
    menu: [
        {
            type: mongoose.Schema.Types.ObjectId, ref: `Dish`,
        }
    ],
    pic: {
        data: Buffer,
        contentType: String
    },
    razorpayCredKey_id: {
        type: String,
        required: true
    },
    razorpayCredKeySecret: {
        type: String,
        required: true
    },
    location: {
        required: true,
        type: String
    },
    usersRated: [
        {
            id: { type: mongoose.Schema.Types.ObjectId, ref: `User` },
            rate: { type: Number },
        }
    ],
    rating: {
        type: Number
    },
    timing: {
        start_time: String,
        end_time: String
    },
    status: {
        type: String,
        enum: ['on', 'off'],
        required: true
    },
    order_types: {
        notCollected: [
            {
                type: String
            }
        ]
        ,
        collected: [
            {
                type: String
            }
        ]
        ,
        rejected: [
            {
                type: String
            }
        ]
        ,
        pending: [
            {
                type: String
            }
        ]
    }
})

module.exports = mongoose.model('Restaurant', restaurant);