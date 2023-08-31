const dbConfig = require("../config/db.config");
const Sequelize = require("sequelize");
const sequelize = new Sequelize(dbConfig.DB, dbConfig.USER, dbConfig.PASSWORD, {
  host: dbConfig.HOST,
  dialect: dbConfig.dialect,
  logging: false,
  operatorsAliases: 0,
  pool: {
    max: dbConfig.pool.max,
    min: dbConfig.pool.min,
    acquire: dbConfig.pool.acquire,
    idle: dbConfig.pool.idle
  }
});
const db = {};
db.Sequelize = Sequelize;
db.sequelize = sequelize;
db.user = require("./user.model")(sequelize, Sequelize);
db.attendance = require("./attendance.model")(sequelize, Sequelize);
db.sentMessage = require("./sentMessage.model")(sequelize, Sequelize);
db.receivedMessage = require("./receivedMessage.model")(sequelize, Sequelize);
//user - attendance relationship
db.attendance.belongsToMany(db.user, {
  through: "user_attendance",
  foreignKey: "attendanceId",
  otherKey: "userId"
});
db.user.belongsToMany(db.attendance, {
  through: "user_attendance",
  foreignKey: "userId",
  otherKey: "attendanceId"
});

db.user.hasMany(db.sentMessage, {
  foreignKey: 'senderId'
})
db.sentMessage.belongsTo(db.user, {
  foreignKey: 'senderId'
})

db.user.belongsToMany(db.receivedMessage, {
  through: 'user_received'
})
db.receivedMessage.belongsToMany(db.user, {
  through: 'user_received'
})
module.exports = db;