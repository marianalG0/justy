import 'package:flutter/material.dart';
import 'package:justy_app/src/pages/homepage.dart';

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
      routes: {'homepage': (BuildContext context) => const homePage()},
    );
  }
}
