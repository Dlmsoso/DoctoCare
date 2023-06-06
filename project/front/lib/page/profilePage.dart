import 'package:docto/provider/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              "/profilePage/edit",
            ),
            child: Text(
              "Éditer",
              style: TextStyle(
                color: Color.fromRGBO(31, 196, 178, 1),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
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
                  ...infoWidget(
                    title: "Prénom",
                    body: context.watch<ProfileProvider>().firstName,
                  ),
                  ...infoWidget(
                    title: "Nom",
                    body: context.watch<ProfileProvider>().lastName,
                  ),
                  ...infoWidget(
                    title: "Date de naissance",
                    body: context.watch<ProfileProvider>().birthToString(),
                  ),
                  ...infoWidget(
                    title: "Ville",
                    body: context.watch<ProfileProvider>().city,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                "/logout",
                (_) => false,
              ),
              child: Text(
                "Se deconnecter",
                style: TextStyle(
                  color: Color.fromRGBO(31, 196, 178, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> infoWidget({
    required String title,
    required String body,
  }) {
    return [
      Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              body,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      const Divider(
        color: Colors.black26,
      ),
    ];
  }
}
