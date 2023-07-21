import 'package:docto/provider/profileProvider.dart';
import 'package:docto/provider/threadProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../thread.dart';

class ThreadPage extends StatefulWidget {
  const ThreadPage({required this.id, super.key});

  final int id;

  @override
  State<ThreadPage> createState() => _ThreadPage(id);
}

class _ThreadPage extends State<ThreadPage> {
  int id;
  int? myId;
  TextEditingController writtingText = TextEditingController();

  _ThreadPage(this.id);

  @override
  void initState() {
    super.initState();
    myId = context.read<ProfileProvider>().id;
  }

  @override
  Widget build(BuildContext context) {
    Thread thread = context.watch<ThreadProvider>().getThread(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(thread.name!),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<ThreadProvider>().updateThread(myId!);
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          chatSection(thread, myId!),
          messageSection(),
        ],
      ),
    );
  }

  Widget chatSection(Thread thread, int myId) => Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            ...thread.conversation
                .map((message) => messageWidget(message, myId))
          ],
        ),
      );

  Widget messageSection() => Container(
        margin: EdgeInsets.only(right: 10, left: 10, bottom: 15),
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            messageFieldWidget(),
            sendMessageIcon(),
          ],
        ),
      );

  Widget messageFieldWidget() => Expanded(
        child: TextField(
          controller: writtingText,
          decoration: InputDecoration(
            hintText: "...",
            border: InputBorder.none,
          ),
        ),
      );

  Widget sendMessageIcon() => IconButton(
        onPressed: () {
          Thread thread = context.read<ThreadProvider>().getThread(id);

          int idRecipient = thread.otherName == null
              ? thread.otherId!
              : context.read<ProfileProvider>().allDoctorMap[thread.otherName]!;

          if (writtingText.text.isNotEmpty) {
            context.read<ThreadProvider>().sendMessage(
                  Message(
                    recipient: idRecipient,
                    sender: myId,
                    text: writtingText.text,
                    threadId: id,
                  ),
                  context.read<ProfileProvider>().id,
                );
            writtingText.clear();
          }
        },
        icon: Icon(Icons.send),
      );

  Widget messageWidget(Message message, int myId) {
    return message.sender == myId
        ? myselfMessageWidget(message.text!)
        : doctorMessageWidget(message.text!);
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
