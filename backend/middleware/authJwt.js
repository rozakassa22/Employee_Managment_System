const jwt = require('jsonwebtoken');
const config = require('../config/auth.config');
const db = require('../models');
const User = db.user;


checkDuplicateEmail = (req, res, next) => {
    User.findOne(
        {
            where: {
                email: req.body.email
            }
        }).then(user => {
            if (user) {
                res.status(400).send({
                    message: "Failed! Email is already in use!"
                });
                return;
            }
            next();
        });
}

verifyToken = (req, res, next) => {
    let token = req.headers["x-access-token"];
    jwt.verify(token, config.secret, (err, decoded) => {
        if (err) {
            return res.status(401).send({
                message: "Unauthorized!"
            });
        }
        req.userId = decoded.id;
        next();
    });
};

isOwner = (req, res, next) => {
    User.findByPk(req.userId)
        .then(user => {
            if (user.role === "owner") {
                next();
                return;
            }
            res.status(403).send({
                message: "Require Owner Role!"
            });
            return;
        })
};

isManager = (req, res, next) => {
    User.findByPk(req.userId)
        .then(user => {
            if (user.role === "manager") {
                next();
                return;
            }
            res.status(403).send({
                message: "Require Manager Role!"
            });
            return;
        });
}
isEmployee = (req, res, next) => {
    User.findByPk(req.userId)
        .then(user => {
            if (user.role === "employee") {
                next();
                return;
            }
            res.status(403).send({
                message: "Require Employee Role!"
            });
            return;
        });
}

const authJwt = {
    checkDuplicateEmail: checkDuplicateEmail,
    verifyToken: verifyToken,
    isOwner: isOwner,
    isManager: isManager,
    isEmployee: isEmployee
};
module.exports = authJwt;