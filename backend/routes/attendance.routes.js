const authJwt = require("../middleware/authJwt");
const attendanceController = require("../controllers/attendance.controller");

module.exports = function (app) {
    app.use(function (req, res, next) {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );
        next();
    });

    //this uses the id of the user
    app.get("/api/attendances/:id", attendanceController.getAttendanceHistoryOfUser);

    //deletes a specific user's attendances from the database this is used when a user deletes it's profile form the database
    app.delete("/api/attendances/:id", attendanceController.deleteAttendanceHistoryOfUser);

    //this will list all the today's attendances from the database
    app.get("/api/attendances", authJwt.verifyToken, attendanceController.getTodayAttendanceOfAllUsers);

    //this uses the id of the user
    app.get("/api/attendances/user/:id", authJwt.verifyToken, attendanceController.getTodayAttendanceOfUser);

    //this users the id of the user
    app.post("/api/attendances/user/:id", attendanceController.createAttendance);


    //this users the id of the specific attendance 
    app.put("/api/attendances/attendance/:id", attendanceController.updateAttendance);

    //this uses the id of the specific attendance
    app.put("/api/attendances/attendance/:id", attendanceController.deleteAttendance);






};