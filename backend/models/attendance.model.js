module.exports = (sequelize, Sequelize) => {
    const Attendance = sequelize.define('attendance', {
        date: {
            type: Sequelize.DATEONLY
        },
        present: {
            type: Sequelize.BOOLEAN
        }
    });
    return Attendance;
}