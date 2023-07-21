import 'dart:math';

import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class Thread {
  Thread({
    this.name,
    this.otherName,
    this.otherId,
    required this.conversation,
  });

  int id = Random().nextInt(99999999);
  int? otherId;
  String? name;
  String? otherName;

  List<Message> conversation = [];

  Thread.fromJson(Map<String, dynamic> json) {
    name = json["thread_name"];
    otherName = json["sender"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'otherName': otherName,
        'id': id,
      };
}

class Message {
  Message({
    this.sender,
    this.recipient,
    this.text,
    this.threadId,
  });

  int? sender;
  int? recipient;
  String? text;
  int? threadId;

  Message.fromJson(Map<String, dynamic> json) {
    sender = json["sender"];
    recipient = json["recipient"];
    text = json["content"];
    threadId = json["thread_id"];
  }

  Map<String, dynamic> toJson(Thread thread, int id) {
    Map<String, dynamic> json = {
      "sender": sender,
      "recipient": recipient,
      "content": text,
      "thread_id": threadId,
      "thread_name": thread.name,
    };
    return json;
  }
}
