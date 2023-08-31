module.exports = (sequelize, Sequelize) => {
    const ReceiverMessage = sequelize.define('received_message', {
        message_id: {
            type: Sequelize.INTEGER
        },
    });
    return ReceiverMessage;
}