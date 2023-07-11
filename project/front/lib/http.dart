import 'dart:convert';

import 'package:docto/thread.dart';
import 'package:http/http.dart' as http;

// Connexion
Future<Map?> apiConnectAccount(String mail, String password) async {
  Map<String, dynamic> json = {
    'email': mail,
    'password': password,
  };

  var response = await http.post(
    Uri.parse('https://epi-doctocare.herokuapp.com/api/user/login'),
    headers: {
      "Content-Type": "application/json; charset=utf-8",
    },
    body: jsonEncode(json),
  );

  if (jsonDecode(response.body)["message"] != null) {
    return null;
  }

  return jsonDecode(response.body);
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
apiGetMessages() async {
  var response = await http.get(
    Uri.parse('https://epi-doctocare.herokuapp.com/api/message/'),
    headers: {
      "Content-Type": "application/json; charset=utf-8",
    },
  );

  return jsonDecode(response.body);
}

// Envoie d'un message
Future<bool> apiSendMessage(Message message, Thread thread, int id) async {
  Map<String, dynamic> json = message.toJson(thread, id);

  var response = await http.post(
    Uri.parse('https://epi-doctocare.herokuapp.com/api/message'),
    headers: {
      "Content-Type": "application/json; charset=utf-8",
    },
    body: jsonEncode(json),
  );
  return true;
}
