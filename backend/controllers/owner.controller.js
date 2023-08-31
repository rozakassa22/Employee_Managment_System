const db = require('../models');
const User = db.user;


//this will be used to find all users that are registerd in the database
exports.findAllApplicants = (req, res) => {
    // const email = req.query.email;
    // var condition = email ? { email: { [Op.like]: `%${email}%` } } : null;
    User.findAll({ where: { approved: false } })
        .then(users => {
            res.status(200).send(users);
        })
        .catch(err => {
            res.status(500).send({
                message:
                    err.message || "Some error occurred while retrieving users."
            });
        });
}

//this is used to appove an applicant from the database
exports.approveUser = (req, res) => {
    const id = req.params.id;
    User.update(req.body, {
        where: { id: id }
    })
        .then(num => {
            if (num == 1) {
                res.status(200).send({
                    message: "Applicant is approved successfully"
                });
            } else {
                res.status(404).send({
                    message: `Cannot approve user with id=${id}. Maybe user was not found or req.body is empty!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error approving user with id=" + id
            });
        });
}
// reject an applicant this will delete them from the database
exports.rejectUser = (req, res) => {
    const id = req.params.id;
    User.destroy({
        where: {
            id: id
        }
    })
        .then(num => {
            if (num == 1) {
                res.send({
                    message: "User was rejected and deleted successfully!"
                });
            } else {
                res.send({
                    message: `Cannot reject and delete User with id=${id}. Maybe user was not found!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Could not reject and delete user with id=" + id
            });
        });
}

//update the role of the user from the database
exports.updateRole = (req, res) => {
    const id = req.params.id;
    User.update(req.body, {
        where: { id: id }
    })
        .then(num => {
            if (num == 1) {
                res.send({
                    message: "User role was updated successfully."
                });
            } else {
                res.send({
                    message: `Cannot update user role with id=${id}. Maybe user was not found or req.body is empty!`
                });
            }
        })
        .catch(err => {
            res.status(500).send({
                message: "Error updating user role with id=" + id
            });
        });
}