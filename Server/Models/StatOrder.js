const mongoose = require('mongoose');
const schema = mongoose.Schema;
const Stationary = require('./Stationary');
const User = require('./User');

const StatOrder = new schema({
    stationaryId: {
        type: mongoose.Schema.Types.ObjectId, ref: `Stationary`
    },
    user_id: {
        type: mongoose.Schema.Types.ObjectId, ref: `User`
    },
    category: {
        type: String,
        enum: ['CA4', 'CA3', 'BWA4', 'BWA3', 'Poster', 'Certificate', 'pvcPrint']
    },
    numberOfCopies: {
        type: Number,
        required: true,
    },
    BothSides: {
        type: Boolean,
        required: true
    },
    Orientation: {
        type: String,
        enum: ['Landscape', 'Portrait']
    },
    Order_status: {
        type: String,
        enum: ['completed', 'accepted', 'rejected', 'paymentPending', 'responsePending']
    },
    total: {
        type: Number,
        required: true
    },
    timeOfOrder: {
        type: Date
    },
    razorpayCred: {
        Key_id: {
            type: String
        },
        KeySecret: {
            type: String
        }
    },
    data: {
        data: Buffer,
        contentType: String
    }
})

module.exports = mongoose.model('StatOrder', StatOrder);