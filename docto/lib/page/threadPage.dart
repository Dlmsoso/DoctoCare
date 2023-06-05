import 'package:docto/provider/threadProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../thread.dart';

class ThreadPage extends StatefulWidget {
  const ThreadPage({required this.id, super.key});

  final String id;

  @override
  State<ThreadPage> createState() => _ThreadPage(id);
}

class _ThreadPage extends State<ThreadPage> {
  String id;
  TextEditingController writtingText = TextEditingController();

  _ThreadPage(this.id);

  @override
  Widget build(BuildContext context) {
    Thread thread = context.watch<ThreadProvider>().getThread(id);
    return Scaffold(
      appBar: AppBar(title: Text(thread.name)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                ...thread.conversation.map((message) => messageWidget(message))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 5),
            padding: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: writtingText,
                    decoration: InputDecoration(
                      hintText: "...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (writtingText.text.isNotEmpty) {
                        context.read<ThreadProvider>().sendMessage(
                              id,
                              Message(
                                author: Author.myself,
                                text: writtingText.text,
                              ),
                            );
                        writtingText.clear();
                      }
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget messageWidget(Message message) {
    return message.author == Author.myself
        ? myselfMessageWidget(message.text)
        : doctorMessageWidget(message.text);
  }

  Widget doctorMessageWidget(String text) {
    return UnconstrainedBox(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        constraints: BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(25),
          color: Color.fromRGBO(252, 228, 214, 1),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget myselfMessageWidget(String text) {
    return UnconstrainedBox(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        constraints: BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(25),
          color: Color.fromRGBO(219, 226, 244, 1),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
