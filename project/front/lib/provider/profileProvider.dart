import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class ProfileProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String? _id = uuid.v4();
  String _firstName = "Maxime";
  String _lastName = "ULMANN";
  DateTime _birth = DateTime(2001);
  String _city = "Saint-Maur-des-Fossés";
  List<String>? _doctorList = ["Medecin 1", "Medecin 2", "Medecin 3"];

  ProfileProvider() {}

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
    required String firstName,
    required String lastName,
    required DateTime birth,
    required String city,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _birth = birth;
    _city = city;
    notifyListeners();
  }

  ProfileProvider.fromJson(Map<String, dynamic> json) {
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _birth = json["birth"];
    _city = json["city"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'firstName': firstName,
        'lastName': lastName,
        'birth': birth,
        'city': city,
      };
}
