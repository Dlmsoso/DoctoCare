import 'package:docto/page/editProfilePage.dart';
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfilePage()),
            ),
            child: Text("Edit"),
          )
        ],
      ),
      body: Container(
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
              alignment: Alignment.center,
              child: Text(
                context.watch<ProfileProvider>().firstName,
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              child: Text(
                context.watch<ProfileProvider>().lastName,
                style: TextStyle(fontSize: 24),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              child: Text(
                context.watch<ProfileProvider>().birth,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
