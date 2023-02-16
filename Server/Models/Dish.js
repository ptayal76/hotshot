const mongoose = require('mongoose');
const schema = mongoose.Schema;
const Restaurant=require('./Restaurant');

const dish = new mongoose.Schema({
    Rest_Id: {
        type: mongoose.Schema.Types.ObjectId, ref: `Restaurant`,
    },
    name: {
        type: String,
        required: true
    },
    category: {
        type: String,
        enum: ['veg', 'nonveg'],
    }, price: {
        type: Number,
        required: true,
    },
    suggestedTime: {
        type: String,
        enum: ['Breakfast', 'Lunch', 'Dinner'],
        
    },
    InStock: {
        type: Boolean,
        required: true,
    },
    pic: {
        data: Buffer,
        contentType: String
    }
})
module.exports= mongoose.model('Dish', dish);
