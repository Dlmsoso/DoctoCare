import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPage();
}

class _ConnexionPage extends State<ConnexionPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FormBuilder(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                connectionTitleWidget(),
                SizedBox(height: 50),
                loginWidget(),
                SizedBox(height: 15),
                passwordWidget(),
                SizedBox(height: 15),
                forgotPasswordWidget(),
                SizedBox(height: 15),
                connectionButton(),
                SizedBox(height: 15),
                createAccountWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget connectionButton() => Container(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            "/mainPage",
            (_) => false,
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 65),
            backgroundColor: Color.fromRGBO(116, 231, 217, 1),
          ),
          child: Text(
            "Connexion",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget connectionTitleWidget() => Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Connexion",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      );

  Widget forgotPasswordWidget() => Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => Navigator.pushNamed(
            context,
            "/recupPassword",
          ),
          child: Text(
            "Mot de passe oublié ?",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );

  Widget createAccountWidget() => Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () => Navigator.pushNamed(
            context,
            "/accountCreation",
          ),
          child: Text(
            "Crée un compte",
            style: TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );

  Widget loginWidget() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Color.fromRGBO(116, 231, 217, 1),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Icon(
              Icons.person,
              color: Colors.white70,
            ),
            SizedBox(width: 3),
            Expanded(
              child: FormBuilderTextField(
                name: "login",
                cursorColor: Colors.black38,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );

  Widget passwordWidget() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Color.fromRGBO(116, 231, 217, 1),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Icon(
              Icons.lock,
              color: Colors.white70,
            ),
            SizedBox(width: 3),
            Expanded(
              child: FormBuilderTextField(
                cursorColor: Colors.black38,
                name: "password",
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );
}
