import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ForgottenPasswordPage extends StatefulWidget {
  const ForgottenPasswordPage({super.key});

  @override
  State<ForgottenPasswordPage> createState() => _ForgottenPasswordPage();
}

class _ForgottenPasswordPage extends State<ForgottenPasswordPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FormBuilder(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(left: 50, right: 50, top: 150),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ForgottenPasswordTitleWidget(),
                SizedBox(height: 50),
                loginWidget(),
                SizedBox(height: 35),
                recupButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget recupButton() => Container(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            "/logout",
            (_) => false,
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 65),
            backgroundColor: Color.fromRGBO(116, 231, 217, 1),
          ),
          child: Text(
            "Récupérer",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget ForgottenPasswordTitleWidget() => Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Mot de passe oublié",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
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
}
