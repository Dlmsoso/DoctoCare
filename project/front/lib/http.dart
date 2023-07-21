import 'dart:convert';
import 'dart:io';

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
Future<bool> apiEditAccount({
  required String firstName,
  required String lastName,
  required String city,
  required int profileId,
  required String token,
  required int idSecu,
}) async {
  Map<String, dynamic> json = {
    'first_name': firstName,
    'last_name': lastName,
    'city': city,
    'id_secu': idSecu,
  };

  try {
    var response = await http.put(
      Uri.parse('https://epi-doctocare.herokuapp.com/api/user/update/' +
          profileId.toString()),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        HttpHeaders.authorizationHeader: token
      },
      body: jsonEncode(json),
    );
  } catch (e) {
    return false;
  }
  return true;
}

// Creation d'un compte
bool apiCreateAccount(Map<String, dynamic> json) {
  return true;
}

// Supprime un thread de conversation
Future<bool> apiDeleteThread(int threadId) async {
  var response = await http.delete(
    Uri.parse(
      'https://epi-doctocare.herokuapp.com/api/message/' + threadId.toString(),
    ),
    headers: {
      "Content-Type": "application/json; charset=utf-8",
    },
  );

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

// Envoie d'un message
Future<bool> apiSendInvit(
  String name,
  String doctorName,
  int id,
  int doctorId,
  String token,
) async {
  Map<String, dynamic> json = {
    'name_pat': name,
    'name_med': doctorName,
    'id_med': doctorId,
    'id_pat': id,
  };

  var response = await http.post(
    Uri.parse('https://epi-doctocare.herokuapp.com/api/patMed/invit'),
    headers: {
      "Content-Type": "application/json; charset=utf-8",
      HttpHeaders.authorizationHeader: token,
    },
    body: jsonEncode(json),
  );
  return true;
}

Future<List> apiGetInvitByDoctor(
  int id,
  String token,
) async {
  var response = await http.get(
    Uri.parse('https://epi-doctocare.herokuapp.com/api/patMed/listMed/' +
        id.toString()),
    headers: {
      "Content-Type": "application/json; charset=utf-8",
      HttpHeaders.authorizationHeader: token,
    },
  );
  return jsonDecode(response.body);
}

Future<bool> apiAcceptInvit(
  int id,
  String token,
) async {
  Map<String, dynamic> json = {'verified': true};
  var response = await http.put(
    Uri.parse('https://epi-doctocare.herokuapp.com/api/patMed/validate/' +
        id.toString()),
    headers: {
      "Content-Type": "application/json; charset=utf-8",
      HttpHeaders.authorizationHeader: token,
    },
    body: jsonEncode(json),
  );

  return true;
}

Future<List> apiGetAllDoctor(
  String token,
) async {
  var response = await http.get(
    Uri.parse('https://epi-doctocare.herokuapp.com/api/user/listMed/'),
    headers: {
      "Content-Type": "application/json; charset=utf-8",
      HttpHeaders.authorizationHeader: token,
    },
  );

  return jsonDecode(response.body);
}

Future<List> apiGetAllDoctorByID(
  int id,
  String token,
) async {
  var response = await http.get(
    Uri.parse('https://epi-doctocare.herokuapp.com/api/patMed/listPat/' +
        id.toString()),
    headers: {
      "Content-Type": "application/json; charset=utf-8",
      HttpHeaders.authorizationHeader: token,
    },
  );

  return jsonDecode(response.body);
}
