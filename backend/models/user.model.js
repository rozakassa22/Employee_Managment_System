module.exports = (sequelize, Sequelize) => {
    const User = sequelize.define('users', {
        email: {
            type: Sequelize.STRING
        },
        password: {
            type: Sequelize.STRING
        },
        approved: {
            type: Sequelize.BOOLEAN
        },
        role: {
            type: Sequelize.STRING
        }
    });
    return User;
}