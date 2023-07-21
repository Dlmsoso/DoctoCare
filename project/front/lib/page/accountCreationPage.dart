import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AccountCreationPage extends StatefulWidget {
  const AccountCreationPage({super.key});

  @override
  State<AccountCreationPage> createState() => _AccountCreationPage();
}

class _AccountCreationPage extends State<AccountCreationPage> {
  TextEditingController birthController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController idSecuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Crée son compte",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: [
                  infoWidget(
                    labelText: "Mail",
                    controller: mailController,
                  ),
                  infoWidget(
                    labelText: "Mot de passe",
                    controller: passwordController,
                  ),
                  infoWidget(
                    labelText: "Prénom",
                    controller: firstNameController,
                  ),
                  infoWidget(
                    labelText: "Nom",
                    controller: lastNameController,
                  ),
                  //birthWidget(),
                  infoWidget(
                    labelText: "Ville",
                    controller: cityController,
                  ),
                  infoWidget(
                    labelText: "Numéro de sécurité sociale",
                    controller: idSecuController,
                  ),
                ],
              ),
            ),
            createAccWidget(),
          ],
        ),
      ),
    );
  }

  Widget infoWidget({
    required String labelText,
    required TextEditingController controller,
  }) =>
      Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget birthWidget() => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: FormBuilderDateTimePicker(
          inputType: InputType.date,
          locale: const Locale("fr", "FR"),
          decoration: InputDecoration(
            labelText: "Date de naissance",
            border: OutlineInputBorder(),
          ),
          controller: birthController,
          name: 'birth',
        ),
      );

  Widget createAccWidget() => Container(
        margin: EdgeInsets.only(bottom: 35),
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
            "Crée son compte",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
}
