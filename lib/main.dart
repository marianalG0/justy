import 'package:flutter/material.dart';

import 'package:justy_app/src/pages/alumno/listaAlum.dart';

import 'package:justy_app/src/pages/grupo/listaGrupo.dart';

// import 'package:justy_app/src/pages/homepage.dart';

import 'package:justy_app/src/pages/inicio_page.dart';

import 'package:justy_app/src/pages/login_page.dart';
import 'package:justy_app/src/pages/persona/listaPersona.dart';
import 'package:justy_app/src/pages/registro_page.dart';

import 'src/listas/grupos_lista.dart';

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
      initialRoute: 'inicio',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'registro': (BuildContext context) => RegistroPage(),
        'inicio': (BuildContext context) => PaginaInit(),
        'grupos': (BuildContext context) => listGrupo(),
        'personas': (BuildContext context) => listPer(),
        'alumnos': (BuildContext context) => AlumnosLista(),
      },
    );
  }
}
