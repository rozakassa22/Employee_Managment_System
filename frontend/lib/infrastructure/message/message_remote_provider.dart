import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/message/message.model.dart';
import '../../domain/message/recivedMessage.model.dart';

class RemoteMessageProvider {
  static const String _baseUrl = "http://localhost:8080/api";

  // url = '/api/:id/message';
  //api/:id/messages
  Future<void> createMessage(
      {required String token,
      required int senderId,
      required List<String> reciverEmail,
      required String message}) async {
    final res = await http.post(Uri.parse("$_baseUrl/$senderId/message"),
        headers: <String, String>{
          "Content-Type": "application/json;charSet=UTF-8",
          "Access-Control-Allow-Headers": "X-Requested-With,content-type",
          "x-access-token": token
        },
        body: jsonEncode({
          "message": message,
          "receiver": reciverEmail,
        }));
    if (res.statusCode == 201) {
      return;
    } else {
      throw Exception("Failed to send message");
    }
  }

  Future<List<ReceivedMessageModel>> getAllRecievedMessages(
      String token, int id) async {
    final res = await http.get(
      Uri.parse("$_baseUrl/$id/received-messages"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type",
        "x-access-token": token
      },
    );
    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      final messages = result['message'] as List;
      // final messages = jsonDecode(res.body) as List;

      return messages
          .map((message) => ReceivedMessageModel.fromJson(message))
          .toList();
    } else {
      throw Exception("Failed to fetch Messages");
    }
  }

  Future<List<MessageModel>> getAllSentMessage(
      {required String token, required int id}) async {
    final res = await http.get(
      Uri.parse("$_baseUrl/$id/sent-messages"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type",
        "x-access-token": token
      },
    );
    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      final messages = result['sent_msg'] as List;

      return messages.map((message) => MessageModel.fromJson(message)).toList();
    } else {
      throw Exception("Failed to fetch Messages");
    }
  }

  Future<MessageModel> getMessageDetail(
      {required String token, required int messageId}) async {
    final res = await http.get(
      Uri.parse("$_baseUrl/api/$messageId"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type",
        "x-access-token": token
      },
    );
    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      print(MessageModel.fromJson(jsonDecode(res.body)));
      // final messages = result['message'] as List;
      // print(messages);
      // final messages = jsonDecode(res.body);

      return MessageModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to fetch Messages");
    }
  }

  // api/:userid/messages/:msgid
  Future<void> updateNotificationDetail(
      {required String token,
      required int messageId,
      required int senderId,
      required String message}) async {
    final res =
        await http.put(Uri.parse("$_baseUrl/$senderId/messages/$messageId"),
            headers: <String, String>{
              "Content-Type": "application/json;charSet=UTF-8",
              "Access-Control-Allow-Headers": "X-Requested-With,content-type",
              "x-access-token": token
            },
            body: jsonEncode({"message": message, "senderId": senderId}));
    if (res.statusCode == 201) {
      return;
    } else {
      throw Exception("Failed to update the message message");
    }
  }

  // api/:userid/messages/:msgid

  Future<void> deleteMessage(
      {required String token,
      required int messageId,
      required int senderId}) async {
    final res = await http.delete(
        Uri.parse("$_baseUrl/$senderId/messages/$messageId"),
        headers: <String, String>{
          "Content-Type": "application/json;charSet=UTF-8",
          "Access-Control-Allow-Headers": "X-Requested-With,content-type",
          "x-access-token": token
        });
    if (res.statusCode == 200) {
      return;
    } else {
      throw Exception("Failed to delete the message message");
    }
  }
}
