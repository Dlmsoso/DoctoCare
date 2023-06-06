import 'package:docto/page/connectionPage.dart';
import 'package:docto/page/doctorListPage.dart';
import 'package:docto/page/editProfilePage.dart';
import 'package:docto/page/mainpage.dart';
import 'package:docto/page/profilePage.dart';
import 'package:docto/page/threadPage.dart';
import 'package:docto/provider/profileProvider.dart';
import 'package:docto/provider/threadProvider.dart';
import 'package:docto/thread.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThreadProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      theme: themeData(),
      home: const ConnexionPage(),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData themeData() => ThemeData(
        useMaterial3: true,
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Color.fromRGBO(31, 196, 178, 1),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(116, 231, 217, 1),
          foregroundColor: Colors.black,
        ),
      );

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ('/mainPage'):
        {
          return MaterialPageRoute(
            builder: (_) => MyHomePage(),
          );
        }
      case ('/logout'):
        {
          return MaterialPageRoute(
            builder: (_) => ConnexionPage(),
          );
        }
      case ('/profilePage'):
        {
          return MaterialPageRoute(
            builder: (_) => ProfilePage(),
          );
        }
      case ('/profilePage/edit'):
        {
          return MaterialPageRoute(
            builder: (_) => EditProfilePage(),
          );
        }
      case ('/doctorListPage'):
        {
          return MaterialPageRoute(
            builder: (_) => DoctorListPage(),
          );
        }
      case ('/doctorListPage/thread'):
        {
          final thread = settings.arguments as Thread;
          return MaterialPageRoute(
            builder: (_) => ThreadPage(id: thread.id),
          );
        }
    }
    return null;
  }
}
