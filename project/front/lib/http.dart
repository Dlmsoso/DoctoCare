import 'package:docto/thread.dart';

Http http = Http();

class Http {
  // Connexion
  bool apiConnectAccount(String mail, String password) {
    Map<String, dynamic> json = {
      'mail': mail,
      'password': password,
    };

    return true;
  }

  // Modification du compte
  bool apiEditAccount(Map<String, dynamic> json) {
    return true;
  }

  // Creation d'un compte
  bool apiCreateAccount(Map<String, dynamic> json) {
    return true;
  }

  // Crée un thread de conversation
  bool apiCreateThread(Thread thread) {
    Map<String, dynamic> json = thread.toJson();

    return true;
  }

  // Supprime un thread de conversation
  bool apiDeleteThread(String threadId) {
    Map<String, dynamic> json = {
      'threadId': threadId,
    };

    return true;
  }

  // Retourne la liste des messages d'un thread
  bool apiGetMessages(String threadId) {
    Map<String, dynamic> json = {
      'threadId': threadId,
    };

    return true;
  }

  // Envoie d'un message
  bool apiSendMessage(Message message) {
    Map<String, dynamic> json = message.toJson();

    return true;
  }
}
