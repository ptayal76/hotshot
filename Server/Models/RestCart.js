const mongoose = require('mongoose');
const Restaurant=require('./Restaurant');
const schema = mongoose.Schema;
const User=require('./User');

const cart = new schema({
    orderlist: [
        {
            dish_id: {
                type: mongoose.Schema.Types.ObjectId, ref: `Restaurant`,
            },
            user_id: { type: mongoose.Schema.Types.ObjectId, ref:`user` },
            quantity:{
                type: Number,
            }
        }
    ]
})
module.exports = mongoose.model('Cart', cart);