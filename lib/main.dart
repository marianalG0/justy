import 'package:flutter/material.dart';
import 'package:justy_app/src/pages/homepage.dart';
import 'package:justy_app/src/pages/inicio_page.dart';
import 'package:justy_app/src/pages/login_page.dart';
import 'package:justy_app/src/pages/registro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'material app',
      debugShowCheckedModeBanner: false,
      initialRoute: 'homepage',
      routes: {
        'homepage': (BuildContext context) => const homePage(),
        'login' : ( BuildContext context ) => LoginPage(),
        'registro' : ( BuildContext context ) => RegistroPage(),
        'inicio' : ( BuildContext context ) => PaginaInit(),
        },
    );
  }
}
