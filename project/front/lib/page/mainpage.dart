import 'package:flutter/material.dart';

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
          profileButton(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            )
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
