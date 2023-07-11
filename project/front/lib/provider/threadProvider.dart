import "package:collection/collection.dart";
import 'package:docto/http.dart';
import 'package:flutter/foundation.dart';

import '../thread.dart';

class ThreadProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<Thread> _threadList = [];

  List<Thread> get threadList => _threadList;

  Future<void> updateThread() async {
    List<List> newThreadList = [];

    List body = await apiGetMessages();

    Map threadGrouped = body.groupListsBy((element) => element["thread_id"]);
    threadGrouped.forEach((k, v) => newThreadList.add(v));

    _threadList = [];

    newThreadList.forEach((List thread) {
      List<Message> conversation = [];

      thread.forEach((message) {
        conversation.add(Message.fromJson(message));
      });

      Thread newThread =
          Thread(name: thread[0]['thread_name'], conversation: []);
      newThread.conversation = conversation;
      newThread.id = thread[0]["thread_id"];

      _threadList.add(newThread);
    });
    notifyListeners();
  }

  void createThread(threadName, otherName) {
    Thread thread =
        Thread(name: threadName, otherName: otherName, conversation: []);

    _threadList.add(
      thread,
    );
    notifyListeners();
  }

  void deleteThread(id) {
    _threadList.removeWhere((thread) => thread.id == id);
    notifyListeners();
  }

  Thread getThread(id) {
    return _threadList.firstWhere((thread) => thread.id == id);
  }

  void sendMessage(Message message, int id) {
    Thread thread = getThread(message.threadId);
    apiSendMessage(message, thread, id);
    getThread(message.threadId).conversation.add(message);
    notifyListeners();
  }
}
