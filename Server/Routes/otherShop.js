const express = require('express');
const jwt = require('jsonwebtoken');
const multer = require('multer');

const OtherShop = require('../Models/OtherShop');
const {
  verifyToken,
  authenticateOwner,
  authorizeOwner,
} = require('../Middlewares/verifyToken');

const router = express.Router();

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

//GET ALL OTHER SHOPS
router.get('/other', async (req, res) => {
  try {
    var Obj = {}
    if (req.query.category) Obj.category = req.query.category
    const otherShops = await OtherShop.find(Obj);
    return res.status(200).json(otherShops);
  } catch (err) {
    return res.status(400).send(err.message);
  }
});

//GET AN OTHER SHOP BY ID
router.get('/other/:otherid', async (req, res) => {
  try {
    const id = req.params.otherid;
    const otherShop = await OtherShop.findById(id);
    if (!otherShop) {
      return res.status(400).json('Wrong id');
    }
    return res.status(200).json(otherShop);
  } catch (err) {
    return res.status(404).send(err.message);
  }
});

//CREATE AN OTHER SHOP
router.post('/other', upload.single('pic'), async (req, res) => {
  try {
    const otherShop = new OtherShop(req.body);
    otherShop.pic.data = req.file.buffer;
    otherShop.pic.contentType = req.file.mimetype;
    await otherShop.save();
    jwt.sign(
      { isowner: true, id: otherShop._id },
      'SecretKey',
      (err, token) => {
        res.header('token', `${token}`);
        return res.status(201).json(otherShop);
      }
    );
  } catch (err) {
    return res.status(400).send(err.message);
  }
});

//UPDATE AN OTHER SHOP
router.put('/other/:otherid', verifyToken, authenticateOwner, authorizeOwner, async (req, res) => {
  try {
    const otherShop = await OtherShop.findByIdAndUpdate(
      req.params.otherid,
      req.body,
      { runValidators: true, new: true }
    );
    return res.status(200).json(otherShop);
  } catch (err) {
    return res.status(400).send(err.message);
  }
}
);

//DELETE AN OTHER SHOP
router.delete('/other/:otherid', verifyToken, authenticateOwner, authorizeOwner, async (req, res) => {
  try {
    await OtherShop.findByIdAndDelete(req.params.otherid);
    return res.status(200).json('Shop has been deleted!');
  } catch (err) {
    return res.status(400).send(err.message);
  }
}
);

module.exports = router;