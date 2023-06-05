import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class Thread {
  Thread({
    required this.name,
    required this.doctorName,
  });

  final String id = uuid.v4();
  final String name;
  final String doctorName;

  List<Message> conversation = [
    Message(author: Author.myself, text: "Bonjour"),
    Message(author: Author.doctor, text: "Je suis occupé."),
  ];
}

class Message {
  Message({
    required this.author,
    required this.text,
  });

  final Author author;
  final String text;
}

enum Author { myself, doctor }
