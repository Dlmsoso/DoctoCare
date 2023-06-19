import 'package:flutter/foundation.dart';

import '../http.dart';
import '../thread.dart';

class ThreadProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<Thread> _threadList = [];

  List<Thread> get threadList => _threadList;

  void createThread(threadName, doctorName) {
    Thread thread = Thread(
      name: threadName,
      doctorName: doctorName,
    );

    if (http.apiCreateThread(thread)) {
      _threadList.add(
        thread,
      );
      notifyListeners();
    }
  }

  void deleteThread(id) {
    if (http.apiDeleteThread(id)) {
      _threadList.removeWhere((thread) => thread.id == id);
      notifyListeners();
    }
  }

  Thread getThread(id) {
    return _threadList.firstWhere((thread) => thread.id == id);
  }

  void sendMessage(Message message) {
    if (http.apiSendMessage(message)) {
      getThread(message.threadId).conversation.add(message);
      notifyListeners();
    }
  }
}
