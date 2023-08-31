const db = require('../models');
const config = require('../config/auth.config');
const User = db.user;
const Op = db.Sequelize.Op;

var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");

exports.signup = (req, res) => {
    User.create({
        email: req.body.email,
        password: bcrypt.hashSync(req.body.password, 6),
        role: req.body.role,
        approved: req.body.approved
    })
        .then(user => {
            res.status(201).send(user);
        })
        .catch(err => {
            res.status(500).send({
                message: err.message || "Couldn't store a user to the database"
            });
        });
};

exports.signin = (req, res) => {
    User.findOne({
        where: {
            email: req.body.email
        }
    })
        .then(user => {
            if (!user) {
                return res.status(404).send({
                    message: "User Not found!"
                });
            }
            var passwordIsValid = bcrypt.compareSync(
                req.body.password,
                user.password
            );
            if (!passwordIsValid) {
                return res.status(401).send({
                    message: "Invalid password!"
                });
            }
            const validity = user.approved;
            if (!validity) {
                res.status(402).send({
                    message: "You are not approved yet!"
                })
            }
            else {
                console.log(validity);
                var token = jwt.sign({ id: user.id }, config.secret, {
                    expiresIn: 86400 // expire after 24 hours
                });
                console.log(token.toString());
                
                res.status(200).send({
                    id: user.id,
                    email: user.email,
                    role: user.role,
                    token: token.toString(),
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: err.message
            });
        });
};
