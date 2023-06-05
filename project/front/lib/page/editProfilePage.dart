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
        leading: IconButton(
          onPressed: () async {
            if (isChangeSave()) {
              Navigator.pop(context);
              return;
            }
            await askForSave();
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: saveProfile,
            child: Text("Sauvegarder"),
          ),
        ],
      ),
      body: FormBuilder(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Icon(
                Icons.person,
                size: 36,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: FormBuilderTextField(
                  name: "firstName",
                  initialValue: context.read<ProfileProvider>().firstName,
                  decoration: InputDecoration(
                    labelText: "Prénom",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: FormBuilderTextField(
                  name: "lastName",
                  initialValue: context.read<ProfileProvider>().lastName,
                  decoration: InputDecoration(
                    labelText: "Nom",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: FormBuilderTextField(
                  name: "birth",
                  initialValue: context.read<ProfileProvider>().birth,
                  decoration: InputDecoration(
                    labelText: "Date de naissance",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isChangeSave() {
    bool sameFirstName = _formKey.currentState?.fields["firstName"]?.value ==
        context.read<ProfileProvider>().firstName;

    bool sameLastName = _formKey.currentState?.fields["lastName"]?.value ==
        context.read<ProfileProvider>().lastName;

    bool samebirth = _formKey.currentState?.fields["birth"]?.value ==
        context.read<ProfileProvider>().birth;
    return sameFirstName && sameLastName && samebirth;
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

  void saveProfile() {
    context.read<ProfileProvider>().setAllProfile(
          firstname: _formKey.currentState?.fields["firstName"]?.value,
          lastName: _formKey.currentState?.fields["lastName"]?.value,
          birth: _formKey.currentState?.fields["birth"]?.value,
        );
  }
}
