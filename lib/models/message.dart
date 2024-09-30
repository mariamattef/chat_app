import 'package:chat_app/constant.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      json[KMessage],
      json['id'],
    );
  }
}
