import 'package:docto/provider/profileProvider.dart';
import 'package:docto/provider/threadProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPage();
}

class _DoctorListPage extends State<DoctorListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ThreadProvider>().updateThread(
          context.read<ProfileProvider>().id,
        );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> threadListWidget = updateCardWidget();
    print(context.read<ProfileProvider>().isDoctor);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => context
                .read<ThreadProvider>()
                .updateThread(context.read<ProfileProvider>().id),
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: threadListWidget.isNotEmpty
          ? ListView(
              children: threadListWidget,
            )
          : Container(
              margin: EdgeInsets.only(left: 25, top: 25),
              child: Text("Vous n'avez pas encore de conversation"),
            ),
      floatingActionButton: context.read<ProfileProvider>().isDoctor
          ? SizedBox()
          : FloatingActionButton.extended(
              label: Text("Nouveau"),
              icon: Icon(Icons.add),
              onPressed: createCardPopUp,
            ),
    );
  }

  List<Widget> updateCardWidget() => context
      .watch<ThreadProvider>()
      .threadList
      .map(
        (thread) => Card(
          child: ListTile(
            title: Text(thread.name!),
            onTap: () {
              Navigator.pushNamed(
                context,
                "/doctorListPage/thread",
                arguments: thread,
              );
            },
            trailing: IconButton(
              onPressed: () => removeThreadWidget(thread),
              icon: Icon(Icons.delete),
            ),
          ),
        ),
      )
      .toList();

  Future<void> createCardPopUp() {
    List<String> doctorList = context.read<ProfileProvider>().doctorList;
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
              title: const Text('Nouveau thread'),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: ListBody(
                    children: <Widget>[
                      TextFormField(
                        controller: threadName,
                        decoration: InputDecoration(
                          hintText: "Nom du thread",
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Un nom vide n\'est pas valide';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
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
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<ThreadProvider>()
                          .createThread(threadName.text, doctorDropdownValue);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> removeThreadWidget(thread) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content:
              Text("Êtes-vous sûr de vouloir supprimer cette conversation ?"),
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
                context.read<ThreadProvider>().deleteThread(thread.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
