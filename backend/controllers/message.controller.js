const { json } = require('express/lib/response');
const { receivedMessage, user } = require('../models');
const db = require('../models');
const User = db.user;
const SentMessage = db.sentMessage;
const ReceivedMessage = db.receivedMessage;


exports.createMessage = async (req, res) => {
    const id = req.params.id;
    const receiver = req.body.receiver
    const messageId = await SentMessage.create({
        message: req.body.message
    })
        .then(sentmessage => {

            User.findByPk(id).then(user => {
                sentmessage.setUser(user)
            })

            return sentmessage.id
        })

    ReceivedMessage.create({
        message_id: messageId
    }).then(receivedmessage => {
        for (index = 0; index < receiver.length; ++index) {
            User.findOne({ where: { email: receiver[index] } }).then(user => {
                receivedmessage.addUser(user)
            }).catch(err => {
                res.status(500).send({
                    message: err.message || "cannot send message"
                });
            });
        }
    }).then(() => {
        res.status(201).send({
            message: "message was sent successfully "
        });
    })
        .catch(err => {
            res.status(400).send({
                message: err.message || "cannot send message"
            });
        });

}


exports.getReceivedMessages = (req, res) => {
    const id = req.params.id;

    User.findByPk(id, {
        include: [{
            model: ReceivedMessage,
            attributes: ["message_id"]
        }
        ]
    })
        .then(messages => {

            let user_msgid = []
            var sender_message_pair;
            let sent_msg = messages.received_messages;
            for (index = 0; index < (sent_msg).length; ++index) {
                user_msgid.push(sent_msg[index].message_id)
            }

            const getSenderMessage = async (id_list) => {
                const sender_message = []

                for (const id of id_list) {
                    const msg = await SentMessage.findByPk(id)
                    const sender = await User.findByPk(msg.senderId)
                    sender_message.push({
                        id: id,
                        message: msg.message,
                        message_sender: sender.email
                    })
                }

                return sender_message
            }

            (async () => {
                sender_message_pair = await getSenderMessage(user_msgid);
                res.status(200).send({
                    message: sender_message_pair
                });
            })()

        })
        .catch(err => {
            res.status(400).send({
                message: err.message || "cannot get message"
            });
        });

}

exports.getSentMessages = (req, res) => {
    const id = req.params.id;
    SentMessage.findAll({ where: { senderId: id } })
        .then(messages => {

            const getSenderMessage = async (message) => {

                let sent_msg = []
                let receiver = []

                for (const msg of message) {
                    await ReceivedMessage.findByPk(msg.id, {
                        include: [{
                            model: User,
                            attributes: ["email", "id"]
                        }
                        ]
                    }).then(result => {

                        for (const user of result.users) {
                            receiver.push({ email: user.email, id: user.id })
                        }


                    }).catch(err => {
                        res.status(400).send({
                            message: "not Found"
                        })
                    })
                    sent_msg.push({ id: msg.id, message: msg.message, receiver: receiver })
                }
                return sent_msg
            }



            (async () => {
                sent_msg = await getSenderMessage(messages);
                res.status(200).send({
                    sent_msg
                });
            })()

        }).catch(err => {
            res.status(400).send({
                message: "cannot get message"
            });
        }).catch(err => {
            res.status(501).send({
                message: "internal server error"
            });
        })

}


exports.updateMessage = async (req, res) => {
    const userid = req.params.userid;
    const msgid = req.params.msgid;
    const new_msg = req.body.message;

    await SentMessage.update(
        {
            message: new_msg,
            senderId: userid
        },
        { where: { id: msgid, senderId: userid } }
    ).then(result => {

        res.status(201).send({
            message: "successfully updated !"
        })
    }
    ).catch(err => {
        res.status(400).send({
            message: "update failed "
        })
    })
}

exports.deleteMessage = async (req, res) => {
    const userid = req.params.userid;
    const msgid = req.params.msgid;

    await SentMessage.destroy(
        { where: { id: msgid, senderId: userid } }
    ).then(() => {
        ReceivedMessage.destroy(
            { where: { message_id: msgid } }
        )
    })
        .then(result => {

            res.status(200).send({
                message: "successfully deleted !"
            })
        }
        ).catch(err => {
            res.status(400).send({
                message: "failed  to delete"
            })
        })
}


exports.getMessagesById = (req, res) => {
    const msgId = req.params.id;

    SentMessage.findByPk(msgId).then(
        result => {
            message = result.message
            response = {
                id: result.id,
                message: message
            }
            res.status(200).send({
                response
            })
        }
    ).catch(err => {
        res.status(400).send({
            message: err.message || "cannot get message"
        });
    });

}