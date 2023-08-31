part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class MessageSend extends MessageEvent {
  final String token;
  final String message;
  final int senderId;
  final List<String> receiverEmail;

  MessageSend({
    required this.token,
    required this.senderId,
    required this.receiverEmail,
    required this.message,
  });

  @override
  List<Object> get props => [token, message, receiverEmail, senderId];
}

class GetRecivedMessages extends MessageEvent {
  final String token;
  final int userId;

  GetRecivedMessages({
    required this.token,
    required this.userId,
  });

  @override
  List<Object> get props => [token, userId];
}

class GetMessageDetail extends MessageEvent {
  final String token;
  final int messageId;

  GetMessageDetail({
    required this.token,
    required this.messageId,
  });

  @override
  List<Object> get props => [token, messageId];
}

class GetSentMessage extends MessageEvent {
  final String token;
  final int userId;

  GetSentMessage({
    required this.token,
    required this.userId,
  });

  @override
  List<Object> get props => [token, userId];
}

class UpdateMessage extends MessageEvent {
  final String token;
  final int messageId;
  final int senderId;
  final String message;

  UpdateMessage({
    required this.token,
    required this.messageId,
    required this.senderId,
    required this.message,
  });

  @override
  List<Object> get props => [token, messageId];
}

class DeleteNotificationDetail extends MessageEvent {
  final String token;
  final int messageId;
  final int senderId;

  DeleteNotificationDetail({
    required this.token,
    required this.messageId,
    required this.senderId,
  });

  @override
  List<Object> get props => [token, messageId];
}