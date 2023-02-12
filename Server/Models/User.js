const mongoose = require('mongoose');
const schema = mongoose.Schema;
const Restaurant=require('./Restaurant');
const Order=require('./RestOrder');
const userSchema = new schema({
    name: {
        required: true,
        type: String
    },
    email: {
        required: true,
        type: String
    },
    order: [
        {
            type: mongoose.Schema.Types.ObjectId, ref: `Order`
        }
    ],
    favRest: [
        {
            type: mongoose.Schema.Types.ObjectId, ref: `Restaurant`
        }
    ],
    phoneNum: {
        required: true,
        type: String
    }
});

module.exports = mongoose.model('User', userSchema);