import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class ProfileProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String _firstName = "Maxime";
  String _lastName = "ULMANN";
  DateTime _birth = DateTime(2001);
  String _city = "Saint-Maur-des-Fossés";
  List<String>? _doctorList = ["Medecin 1", "Medecin 2", "Medecin 3"];

  List<String> get doctorList => _doctorList!;

  String get firstName => _firstName;

  String get lastName => _lastName;

  DateTime get birth => _birth;

  String get city => _city;

  String birthToString() {
    return DateFormat("dd/MM/yyyy").format(birth);
  }

  void set setFirstName(String firstName) {
    _firstName = firstName;
  }

  void set setLastName(String lastName) {
    _lastName = lastName;
  }

  void set setBirth(DateTime birth) {
    _birth = birth;
  }

  void setAllProfile({
    required String firstname,
    required String lastName,
    required DateTime birth,
    required String city,
  }) {
    _firstName = firstname;
    _lastName = lastName;
    _birth = birth;
    _city = city;
    notifyListeners();
  }
}
