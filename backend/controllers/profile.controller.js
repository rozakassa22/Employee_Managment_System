const db = require('../models');
const User = db.user;
var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");
//List all user profiles in the database
exports.listAllProfiles = (req, res) => {
    User.findAll()
        .then(data => {
            res.status(200).send(data);
        })
        .catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while retrieving user profiles."
            });
        });
}

//view a profile of an individual user
exports.getProfile = (req, res) => {
    const id = req.params.id;
    User.findByPk(id)
        .then(data => {
            if (data) {

                res.status(200).send(data);
            } else {
                res.status(404).send({
                    message: `Cannot find User with id=${id}.`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error retrieving User with id=" + id
            });
        });
};

//update a profile of the user with a specified id
exports.updateProfile = (req, res) => {
    const id = req.params.id;
    const password = req.body.password;
    const email = req.body.email;

    User.update({
        email: email,
        password: bcrypt.hashSync(password, 6)
    }, {
        where: { id: id }
    })
        .then(num => {
            console.log(num);
            if (num == 1) {

                res.status(200).send({
                    message: "User profile was updated successfully."
                });
            } else {
                res.status(404).send({
                    message: `Cannot update user profile with id=${id}. Maybe user was not found or req.body is empty!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error updating user profile with id=" + id
            });
        });
}

//delete a profile from the database
exports.deleteProfile = (req, res) => {
    const id = req.params.id;
    User.destroy({
        where: { id: id }
    })
        .then(num => {
            if (num == 1) {
                res.send({
                    message: "User profile was deleted successfully!"
                });
            } else {
                res.send({
                    message: `Cannot delete user profile with id=${id}. Maybe user was not found!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Could not delete user profile with id=" + id
            });
        });
}

