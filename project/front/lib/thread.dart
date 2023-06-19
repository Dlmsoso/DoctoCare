import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class Thread {
  Thread({
    this.name,
    this.doctorName,
  });

  String id = uuid.v4();
  String? name;
  String? doctorName;

  List<Message> conversation = [
    Message(author: Author.myself, text: "Bonjour"),
    Message(author: Author.doctor, text: "Je suis occupé."),
  ];

  Thread.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    doctorName = json["doctorName"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'doctorName': doctorName,
        'id': id,
      };
}

class Message {
  Message({
    this.author,
    this.text,
    this.threadId,
  });

  Author? author;
  String? text;
  String? threadId;

  Message.fromJson(Map<String, dynamic> json) {
    author = json["author"];
    text = json["text"];
    threadId = json["threadId"];
  }

  Map<String, dynamic> toJson() => {
        'author': author,
        'text': text,
        'threadId': threadId,
      };
}

enum Author { myself, doctor }
