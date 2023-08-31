part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageSentSuccessfully extends MessageState {}

class MessageFailure extends MessageState {
  final Object message;

  MessageFailure(this.message);

  @override
  List<Object> get props => [message];
}

class RecivedMessagesLoaded extends MessageState {
  final List<ReceivedMessageModel> messages;

  const RecivedMessagesLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class SentMessagesLoaded extends MessageState {
  final List<MessageModel> messages;

  const SentMessagesLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class NotificationDeleted extends MessageState {}

class MessageDetailLoaded extends MessageState {
  final MessageModel message;

  const MessageDetailLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class NotificationDetailUpdated extends MessageState {}
