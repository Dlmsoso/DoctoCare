import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class ProfileProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _id = 1;
  String _firstName = "Maxime";
  String _lastName = "ULMANN";
  DateTime _birth = DateTime(2001);
  String _city = "Saint-Maur-des-Fossés";
  List<String>? _doctorList = ["Medecin 1", "Medecin 2"];
  Map<String, int> _allDoctorMap = {
    "Medecin 1": 1,
    "Medecin 2": 2,
    "Medecin 3": 3,
    "Medecin 4": 4,
  };
  String? _token;
  bool _isDoctor = false;
  int? _idSecu;

  ProfileProvider() {}

  String? get token => _token;
  int? get idSecu => _idSecu;
  bool get isDoctor => _isDoctor;

  List<String> get doctorList => _doctorList!;
  Map<String, int> get allDoctorMap => _allDoctorMap;

  String get firstName => _firstName;

  String get lastName => _lastName;

  DateTime get birth => _birth;

  String get city => _city;

  int get id => _id;

  String birthToString() {
    return DateFormat("dd/MM/yyyy").format(birth);
  }

  void set allDoctorMap(Map<String, int> allDoctorMap) {
    _allDoctorMap = allDoctorMap;
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
    DateTime? birth,
    required String city,
    int? id,
    int? idSecu,
    String? token,
    bool? isDoctor,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    if (birth != null) {
      _birth = birth;
    }
    _city = city;
    if (id != null) {
      _id = id;
    }
    if (idSecu != null) {
      _idSecu = idSecu;
    }

    if (token != null) {
      _token = token;
    }

    if (isDoctor != null) {
      _isDoctor = isDoctor;
    }

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
