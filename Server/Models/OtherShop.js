const mongoose = require('mongoose');

const otherShopSchema = new mongoose.Schema({
  ownerName: {
    required: true,
    type: String,
  },
  shopName: {
    required: true,
    type: String,
  },
  phoneNumber: {
    required: true,
    type: String,
  },
  email: {
    required: true,
    type: String,
  },
  category: {
    enum: ['hospital', 'bank', 'souvenir', 'mobileRepair', 'cycle', 'barber','other'],
    type:String,
    default:"other"
  },
  pic: {
    data: Buffer,
    contentType: String
  },
  location: {
    required: true,
    type: String,
  },
  description: {
    type: String,
  },
  status: {
    type: String,
    enum: ['open', 'close'],
    default: 'open',
  },
});

const OtherShop = mongoose.model('OtherShop', otherShopSchema);

module.exports = OtherShop;