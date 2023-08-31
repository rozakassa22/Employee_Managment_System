module.exports = (sequelize, Sequelize) => {
    const SentMessage = sequelize.define('sent_message', {
        message: {
            type: Sequelize.TEXT
        },
        read: {
            type: Sequelize.BOOLEAN
        },
    });
    return SentMessage;
}