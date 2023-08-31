const authJwt = require("../middleware/authJwt");
const ownerController = require("../controllers/owner.controller");

module.exports = function (app) {
    app.use(function (req, res, next) {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );
        next();
    });
    // app.get(
    //     "/api/owner",
    //     [authJwt.verifyToken, authJwt.isOwner],
    //     controller.ownerBoard
    // );

    //all routes related to authontication involving the owner of the app
    // returns all users applicants from the database
    app.get("/api/applicants", ownerController.findAllApplicants);
    app.put("/api/applicants/:id", ownerController.approveUser);
    app.delete("/api/applicants/:id", ownerController.rejectUser);
    //update the role of an individual user
    app.put("/api/users/:id", ownerController.updateRole);
    
    
};