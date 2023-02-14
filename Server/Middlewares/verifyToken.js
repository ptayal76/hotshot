const jwt = require('jsonwebtoken');
const Restaurant = require('../Models/Restaurant');
const User=require("../Models/User")
const Owner = Restaurant;

const verifyToken = (req, res, next) => {
    const bearerHeader = req.headers['authorization'];
    if (typeof bearerHeader !== 'undefined') {
        const bearerToken = bearerHeader.split(' ')[1];
        req.token = bearerToken;
        next();
    } else {
        res.status(403).json('Invalid Token');
    }
}

const authenticateUser = async (req, res, next) => {
    jwt.verify(req.token, process.env.JWT_SEC, async (err, authData) => {
        if (err) {
            res.status(403).json('Authentication failed');
        }
        else {
            if (authData.isowner) {
                res.status(403).json('Unauthenticated user!');
            } else {
                const user = await User.findById(authData.id);
                if (!user) {
                    res.status(403).json('Not auth user!');
                } else {
                    req.user = authData.id;
                    next();
                }
            }
        }
    })
}

const authorizeUser = (req, res, next) => {
    if (req.user === req.params.userid) {
        next();
    } else {
        res.sendStatus(400);
    }
}

const authenticateOwner = async (req, res, next) => {
    jwt.verify(req.token, process.env.JWT_SEC, async (err, authData) => {
        if (err) {
            res.status(403).json('Error!');
        } else {
            console.log(authData)
            if (!authData.isowner) {
                res.status(403).json('Not auth owner!');
            }
            else {
                const owner = await Owner.findById(authData.id);
                if (!owner) {
                    res.status(403).json('Unauthenticated owner!');
                }
                else {
                    req.restaurant = authData.id;
                    req.isowner = authData.isowner;
                    next();
                }
            }
        }
    })
}

const authorizeOwner = (req, res, next) => {
    if (req.restaurant === req.params.restid) {
        next();
    }
    else {
        res.sendStatus(400);
    }
}

const restOrder = (req, res, next) => {
    jwt.verify(req.token, process.env.JWT_SEC, async (err, authData) => {
        if (!authData.owner) {
            next()
        }
    })
}

const authenticate=(req,res,next)=>{
    jwt.verify(req.token, process.env.JWT_SEC, async (err, authData) => {
        if (err) {
            res.status(403).json('Authentication failed');
        }
        else {
            if (authData.isowner) {
                req.isowner=true
                req.restaurant=authData.id
            } else {
                const user = await User.findById(authData.id);
                if (!user) {
                    res.status(403).json('Not auth user!');
                } else {
                    req.isowner=false;
                    req.user = authData.id;
                    next();
                }
            }
        }
    })
}

module.exports = {
    verifyToken,
    authenticateOwner,
    authorizeOwner,
    authenticateUser,
    authorizeUser,
    restOrder,
    authenticate
};