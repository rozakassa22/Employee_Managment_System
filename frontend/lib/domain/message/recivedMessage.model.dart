class ReceivedMessageModel {
  final int? id;
  final String? message;
  final String? message_sender;

  ReceivedMessageModel({
    this.id,
    required this.message,
    required this.message_sender,
  });

  factory ReceivedMessageModel.fromJson(Map<String, dynamic> json) {
    return ReceivedMessageModel(
      id: json['id'],
      message: json['message'],
      message_sender: json['message_sender'],
    );
  }
}
