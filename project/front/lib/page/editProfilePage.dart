import 'package:docto/http.dart';
import 'package:docto/provider/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: closeButton(),
        actions: [
          saveButton(),
        ],
      ),
      body: FormBuilder(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    iconWidget(),
                    firstNameWidget(),
                    lastNameWidget(),
                    cityWidget(),
                    idSecuWidget(),
                  ],
                ),
              ),
              //addDoctorWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget addDoctorWidget() => context.read<ProfileProvider>().isDoctor
      ? SizedBox()
      : Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: addDoctorPopup,
            child: Text(
              "Ajouter un medecin",
              style: TextStyle(
                color: Color.fromRGBO(31, 196, 178, 1),
              ),
            ),
          ),
        );

  Future<void> addDoctorPopup() {
    Map<String, int> doctorMap = context.read<ProfileProvider>().allDoctorMap;
    List<String> doctorList = doctorMap.keys.toList();

    String doctorDropdownValue = doctorList.first;
    TextEditingController threadName = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Nouveau docteur'),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: ListBody(
                    children: <Widget>[
                      DropdownButton(
                        value: doctorDropdownValue,
                        items: doctorList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            doctorDropdownValue = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Retour'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Confirmer'),
                  onPressed: () {
                    String name = context.read<ProfileProvider>().firstName +
                        " " +
                        context.read<ProfileProvider>().lastName;
                    String doctorName = doctorDropdownValue;
                    int id = context.read<ProfileProvider>().id;
                    int doctorId = doctorMap[doctorName]!;
                    String token = context.read<ProfileProvider>().token!;

                    apiSendInvit(name, doctorName, id, doctorId, token);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget closeButton() => IconButton(
        onPressed: () async {
          if (isChangeSave()) {
            Navigator.pop(context);
            return;
          }
          await askForSave();
        },
        icon: Icon(Icons.close),
      );

  Widget saveButton() => TextButton(
        onPressed: saveProfile,
        child: Text(
          "Sauvegarder",
          style: TextStyle(
            color: Color.fromRGBO(31, 196, 178, 1),
          ),
        ),
      );

  Widget iconWidget() => Icon(
        Icons.person,
        size: 36,
      );

  Widget firstNameWidget() => Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: FormBuilderTextField(
          name: "firstName",
          initialValue: context.read<ProfileProvider>().firstName,
          decoration: InputDecoration(
            labelText: "Prénom",
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget lastNameWidget() => Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: FormBuilderTextField(
          name: "lastName",
          initialValue: context.read<ProfileProvider>().lastName,
          decoration: InputDecoration(
            labelText: "Nom",
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget birthWidget() => Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: FormBuilderDateTimePicker(
          inputType: InputType.date,
          locale: const Locale("fr", "FR"),
          name: "birth",
          initialValue: context.read<ProfileProvider>().birth,
          decoration: InputDecoration(
            labelText: "Date de naissance",
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget cityWidget() => Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: FormBuilderTextField(
          name: "city",
          initialValue: context.read<ProfileProvider>().city,
          decoration: InputDecoration(
            labelText: "Ville",
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget idSecuWidget() => Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: FormBuilderTextField(
          name: "idSecu",
          initialValue: context.read<ProfileProvider>().idSecu.toString(),
          decoration: InputDecoration(
            labelText: "Numéro de sécurité sociale",
            border: OutlineInputBorder(),
          ),
        ),
      );

  bool isChangeSave() {
    bool sameFirstName = _formKey.currentState?.fields["firstName"]?.value ==
        context.read<ProfileProvider>().firstName;

    bool sameLastName = _formKey.currentState?.fields["lastName"]?.value ==
        context.read<ProfileProvider>().lastName;

    bool sameCity = _formKey.currentState?.fields["city"]?.value ==
        context.read<ProfileProvider>().city;

    bool sameIdSecu = _formKey.currentState?.fields["idSecu"]?.value ==
        context.read<ProfileProvider>().idSecu.toString();

    return sameFirstName && sameLastName && sameCity && sameIdSecu;
  }

  Future<void> askForSave() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Quitter sans sauvegarder'),
              content:
                  Text("Êtes vous sûr de vouloir quitter sans sauvegarder ?"),
              actions: <Widget>[
                TextButton(
                  child: const Text('Non'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: const Text('Oui'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> saveProfile() async {
    String token = context.read<ProfileProvider>().token!;
    String firstName = _formKey.currentState?.fields["firstName"]?.value;
    String lastName = _formKey.currentState?.fields["lastName"]?.value;
    //String birth = _formKey.currentState?.fields["birth"]?.value;
    String city = _formKey.currentState?.fields["city"]?.value;
    int profileId = context.read<ProfileProvider>().id;
    int idSecu = int.parse(_formKey.currentState?.fields["idSecu"]?.value);

    bool success = await apiEditAccount(
      token: token,
      firstName: firstName,
      lastName: lastName,
      city: city,
      profileId: profileId,
      idSecu: idSecu,
    );

    if (success == true) {
      context.read<ProfileProvider>().setAllProfile(
            firstName: _formKey.currentState?.fields["firstName"]?.value,
            lastName: _formKey.currentState?.fields["lastName"]?.value,
            birth: _formKey.currentState?.fields["birth"]?.value,
            city: _formKey.currentState?.fields["city"]?.value,
          );
    }
  }
}
