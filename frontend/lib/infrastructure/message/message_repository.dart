import 'package:employee_management_system/presentation/presentation_index.dart';

import '../../domain/message/recivedMessage.model.dart';
import 'message_remote_provider.dart';

class MessageRepository {
  final RemoteMessageProvider remoteMessageProvider;

  MessageRepository(this.remoteMessageProvider);

  Future<void> createMessage(
      {required String token,
      required int senderId,
      required List<String> reciverEmail,
      required String message}) async {
    return remoteMessageProvider.createMessage(
        message: message,
        reciverEmail: reciverEmail,
        senderId: senderId,
        token: token);
  }

  Future<List<ReceivedMessageModel>> getAllRecievedMessages(
      String token, int id) async {
    return remoteMessageProvider.getAllRecievedMessages(token, id);
  }

  Future<MessageModel> getMessageDetail(
      {required String token, required int messageId}) async {
    return remoteMessageProvider.getMessageDetail(
        token: token, messageId: messageId);
  }

  Future<List<MessageModel>> getAllSentMessage({required String token, required int id}) async {
    return remoteMessageProvider.getAllSentMessage(token: token, id: id);
  }

  Future<void> updateNotificationDetail({required String token, required int messageId, required int senderId, required String message}) async {
    return remoteMessageProvider.updateNotificationDetail(token: token, messageId: messageId, senderId: senderId, message: message);
  }

  Future<void> deleteMessage({required String token, required int messageId, required int senderId}) async {
    return remoteMessageProvider.deleteMessage(token: token, messageId: messageId, senderId: senderId);
  }
}
