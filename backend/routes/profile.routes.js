const authJwt  = require("../middleware/authJwt");
const controller = require("../controllers/profile.controller");

module.exports = function (app) {
    app.use(function (req, res, next) {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );
        next();
    });

    app.get("/api/profiles", authJwt.verifyToken, controller.listAllProfiles);
    app.get("/api/profiles/:id", authJwt.verifyToken, controller.getProfile);
    app.put("/api/profiles/:id", authJwt.verifyToken, controller.updateProfile);
    app.delete("/api/profiles/:id", authJwt.verifyToken, controller.deleteProfile);
}