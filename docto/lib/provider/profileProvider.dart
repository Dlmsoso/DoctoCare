import 'package:flutter/foundation.dart';

class ProfileProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String? name;
  List<String>? _doctorList = ["Medecin 1", "Medecin 2", "Medecin 3"];

  List<String> get doctorList => _doctorList!;
}
