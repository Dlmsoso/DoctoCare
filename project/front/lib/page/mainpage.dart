import 'package:docto/http.dart';
import 'package:docto/provider/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          context.read<ProfileProvider>().isDoctor
              ? notifButton()
              : addDoctorButton(),
          profileButton(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/docteur.png",
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            mainWidget(
              title: "Chatter, Medecin",
              body: "Conversation en thread avec les medecins traitant",
              onPressed: () => Navigator.pushNamed(
                context,
                "/doctorListPage",
              ),
            ),
            SizedBox(height: 20),
            mainWidget(
              title: "Mes info, Data",
              body: "Toute les données médicales",
              onPressed: () => print('info'),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget profileButton() => IconButton(
        icon: Icon(
          Icons.person,
          size: 36,
        ),
        onPressed: () => Navigator.pushNamed(
          context,
          "/profilePage",
        ),
      );

  Widget notifButton() => IconButton(
        icon: Icon(
          Icons.notifications,
          size: 36,
        ),
        onPressed: () => notifPopup(),
      );

  invitSnackBar() => SnackBar(
        backgroundColor: Color.fromRGBO(31, 196, 178, 1),
        content: Align(
          alignment: Alignment.center,
          child: Text(
            'Invitation accepter',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );

  Future<void> notifPopup() async {
    int id = context.read<ProfileProvider>().id;
    String token = context.read<ProfileProvider>().token!;

    List response = await apiGetInvitByDoctor(id, token);

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Notification'),
              content: SizedBox(
                height: 200,
                width: 200,
                child: ListView(
                  children: response
                      .where((invit) => invit["verified"] == false)
                      .map(
                        (invit) => Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.black12,
                          child: Row(
                            children: [
                              Expanded(child: Text(invit['name_pat'])),
                              IconButton(
                                onPressed: () {
                                  apiAcceptInvit(invit['id'], token);
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(invitSnackBar());
                                },
                                icon: Icon(Icons.check),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Quitter'),
                  onPressed: () {
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

  Widget addDoctorButton() => IconButton(
        onPressed: addDoctorPopup,
        icon: Icon(Icons.add_reaction),
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
}

Widget mainWidget({
  required String title,
  required String body,
  required void Function() onPressed,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 50),
    height: 100,
    width: double.infinity,
    child: FilledButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Column(
        children: [
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Text(
            body,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
