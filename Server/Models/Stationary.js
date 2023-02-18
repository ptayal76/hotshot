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
    CA4: {
        availability: {
            type: Boolean,
            required: true
        },
        price: {
            type: Number,
            required: true
        }
    },
    CA3: {
        availability: {
            type: Boolean,
            required: true
        },
        price: {
            type: Number,
            required: true
        }
    },
    Poster: {
        availability: {
            type: Boolean,
            required: true
        },
        price: {
            type: Number,
            required: true
        }
    },
    Certificate: {
        availability: {
            type: Boolean,
            required: true
        },
        price: {
            type: Number,
            required: true
        }
    },
    PVCPrint: {
        availability: {
            type: Boolean,
            required: true
        },
        price: {
            type: Number,
            required: true
        }
    },
    BWA4: {
        availability: {
            type: Boolean,
            required: true
        },
        price: {
            type: Number,
            required: true
        }
    },
    BWA3: {
        availability: {
            type: Boolean,
            required: true
        },
        price: {
            type: Number,
            required: true
        }
    },
    pic: {
        availability: {
            type: Boolean,
            required: true
        },
        price: {
            type: Number,
            required: true
        }
    },
    location: {
        availability: {
            type: Boolean,
            required: true
        },
        price: {
            type: Number,
            required: true
        }
    },
    rating: {
        availability: {
            type: Boolean,
            required: true
        },
        price: {
            type: Number,
            required: true
        }
    },
    timing: {

        start_time: {
            type: Date,
            required: true
        },
        end_time: {
            type: Date,
            required: true
        },

    },
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