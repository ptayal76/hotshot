const express = require('express');
const router = express.Router();
const multer = require('multer');
const {
  verifyToken,
  authenticateOwner,
  authorizeOwner,
} = require('../Middlewares/verifyToken');
const Stationary = require('../Models/Stationary');
const jwt = require('jsonwebtoken');

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

router.get('/stationary/stationaryShop', async (req, res) => {
  try {
    const stationaries = await Stationary.find();
    return res.json(stationaries);
  } catch (err) {
    return res.status(400).send(err.message);
  }
});

router.get('/stationary/stationaryShop/:id', async (req, res) => {
  try {
    const id = req.params.id;
    const stationary = await Stationary.findById(id);
    return res.json(stationary);
  } catch (err) {
    return res.status(400).send(err.message);
  }
});

router.post('/stationary/stationaryShop', async (req, res) => {
  try {
    const stationary = new Stationary(req.body);
    stationary.pic.data = req.file.buffer;
    stationary.pic.contentType = req.file.mimetype;
    await stationary.save();

    jwt.sign(
      { isowner: true, id: stationary._id },
      process.env.JWT_SEC,
      (err, token) => {
        res.header('token', `${token}`);
        return res.json(stationary);
      }
    );
  } catch (err) {
    res.status(400).send(err.message);
  }
});

router.put(
  '/stationary/stationaryShop/:statid',
  verifyToken,
  authenticateOwner,
  authorizeOwner,
  async (req, res) => {
    const stationary = await Stationary.findByIdAndUpdate(
      req.params.statid,
      req.body,
      { runValidators: true, new: true }
    );
    res.json(stationary);
  }
);

router.delete(
  '/stationary/stationaryShop/:statid',
  verifyToken,
  authenticateOwner,
  authorizeOwner,
  async (req, res) => {
    try {
      await Stationary.findByIdAndDelete(req.params.statid);
      res.status(200).json('Stationary has been deleted!');
    } catch (err) {
      res.status(500).json(err);
    }
  }
);

module.exports = router;
