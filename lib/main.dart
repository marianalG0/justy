import 'package:flutter/material.dart';


import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:justy_app/src/pages/alumno/listaAlum.dart';
import 'package:justy_app/src/pages/docentes/listaDoc.dart';

import 'package:justy_app/src/pages/grupo/listaGrupo.dart';

import 'package:justy_app/src/pages/grupodoc/listagrupoDoc.dart';

// import 'package:justy_app/src/pages/homepage.dart';

import 'package:justy_app/src/pages/inicio_page.dart';

import 'package:justy_app/src/pages/login_page.dart';
import 'package:justy_app/src/pages/persona/listaPersona.dart';
import 'package:justy_app/src/pages/registro_page.dart';

import 'src/pages/justificaciones/listJusti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // English
        Locale('es', 'ES'), // Spanish
      ],
      title: 'material app',
      debugShowCheckedModeBanner: false,
      initialRoute: 'inicio',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'registro': (BuildContext context) => RegistroPage(),
        'inicio': (BuildContext context) => PaginaInit(),
        'grupos': (BuildContext context) => listGrupo(),
        'personas': (BuildContext context) => listPer(),
        'alumnos': (BuildContext context) => listAlum(),
        'docentes': (BuildContext context) => listDoc(),
        'grupoDoc': (BuildContext context) => ListaGrupodoc(),
        //'grupoDoc':(BuildContext context) => listgD(),
        'justificaciones': (BuildContext context) => listJusty(),
      },
    );
  }
}
