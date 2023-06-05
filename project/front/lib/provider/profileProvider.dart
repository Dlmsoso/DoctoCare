import 'package:flutter/foundation.dart';

class ProfileProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String _firstName = "Maxime";
  String _lastName = "ULMANN";
  String _birth = "19/09/2001";
  List<String>? _doctorList = ["Medecin 1", "Medecin 2", "Medecin 3"];

  List<String> get doctorList => _doctorList!;

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get birth => _birth;

  void set setFirstName(String firstName) {
    _firstName = firstName;
  }

  void set setLastName(String lastName) {
    _lastName = lastName;
  }

  void set setBirth(String birth) {
    _birth = birth;
  }

  void setAllProfile({
    required String firstname,
    required String lastName,
    required String birth,
  }) {
    _firstName = firstname;
    _lastName = lastName;
    _birth = birth;
    notifyListeners();
  }
}
