const express = require("express");
const cors = require("cors");
var bcrypt = require("bcryptjs");
const bodyParser = require("body-parser");

const app = express();
// var corsOptions = {
//     origin: "http://localhost:8081"
// };

app.use(cors());
// parse requests of content-type - application/json
app.use(bodyParser.json());
// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }));

const db = require("./models");
const User = db.user;
db.sequelize.sync({ force: false }).then(() => {
    console.log("database is connected successfully");
    initial();
});

function initial() {

    User.findOrCreate({
        where: { role: "owner" },
        defaults: {
            email: "admin@example.com",
            password: bcrypt.hashSync('123456', 6),
            role: "owner",
            approved: 1
        }
    }).then(([user, created]) => {
        console.log("name = " + user.email, "password = " + user.password, "role = " + user.role)
        if (created) {
            console.log("owner was succesfully registered.");
        }

        else {
            console.log("Owner already exists")
        }
    });
}

require('./routes/auth.routes')(app);
require('./routes/owner.routes')(app);
require('./routes/profile.routes')(app);
require('./routes/attendance.routes')(app);
require('./routes/message.routes')(app);




// Simple test route
app.get("/", (req, res) => {
    res.json({
        message: "Welcome to the app"
    })
})

// set port, listen for requests
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
    console.log(`server is runnning on port ${PORT}`)
});
