import 'package:flutter/foundation.dart';

import '../http.dart';
import '../thread.dart';

class ThreadProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<Thread> _threadList = [];

  List<Thread> get threadList => _threadList;

  void createThread(threadName, doctorName) {
    if (http.apiCreateThread()) {
      _threadList.add(
        Thread(name: threadName, doctorName: doctorName),
      );
      notifyListeners();
    }
  }

  void deleteThread(id) {
    if (http.apiDeleteThread()) {
      _threadList.removeWhere((thread) => thread.id == id);
      notifyListeners();
    }
  }

  Thread getThread(id) {
    return _threadList.firstWhere((thread) => thread.id == id);
  }

  void sendMessage(id, Message message) {
    if (http.apiSendMessage()) {
      getThread(id).conversation.add(message);
      notifyListeners();
    }
  }
}
