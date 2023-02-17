const mongoose = require('mongoose');
const schema = mongoose.Schema;

const stationary = new schema({
    Owner_name: {
        required: true,
        type: String
    },
    StationaryName: {
        required: true,
        type: String
    },
    PhoneNumber: {
        required: true,
        type: String
    }, 
    Email: {
        required: true,
        type: String
    },
    password: {
        type: String
    },
    CA4:{
        type:Boolean,
        default:false
    },
    CA3:{
        type:Boolean,
        default:false
    },
    Poster:{
        type:Boolean,   
        default:false
    },
    Certificate:{
        type:Boolean,
        default:false
    },
    PVCPrint:{
        type:Boolean,
        default:false
    },
    BWA4:{
        type:Boolean,
        default:false
    },
    BWA3:{
        type:Boolean,
        default:false
    },
    pic: {
        data: Buffer,
        contentType: String
    },
    location: {
        type: String
    },
    rating: {
        type: Number
    },
    timing: [
        {
            start_time: Date
        },
        {
            end_time: Date
        }
    ],
    status: {
        type: String,
        enum: ['on', 'off']
    },
    order_types: {
        not_collected: [
            {
                type: String
            }
        ],
        collected: [
            {
                type: String
            }
        ],
        rejected: [
            {
                type: String
            }
        ],
        pending: [
            {
                type: String
            }
        ]
    }
})


module.exports = mongoose.model('Stationary', stationary);