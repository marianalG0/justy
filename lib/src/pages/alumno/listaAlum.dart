import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:justy_app/src/forms/form_alumnos.dart';
import 'package:justy_app/src/pages/alumno/formAlum.dart';

class AlumnosLista extends StatelessWidget {
  AlumnosLista({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        _appBar(context),
        Expanded(child: _lista(context)),
      ]),
      floatingActionButton: _botonAgregar(context),
    );
  }

  Future _listarAlumnos() async {
    try {
      final response =
          await http.post(Uri.parse("http://192.168.1.81/justy/leeralum.php"));

      if (response.statusCode == 200) {
        var datauser = jsonDecode(response.body);
        var mensaje = datauser.toString();

        if (mensaje.length > 0) {
          // La consulta fue exitosa
          return datauser;
        }
      }
    } catch (e) {
      print("ufff, entró en el catch");
      print(e);
      return [];
    }
    return [];
  }

  Widget _appBar(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final buscador = Container(
      margin: EdgeInsets.only(top: size.height * 0.12, left: size.width * 0.08),
      width: size.width * 0.85,
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide.none),
            hintText: 'Buscar...',
            suffixIcon: Icon(Icons.search),
            suffixIconColor: Color.fromRGBO(91, 74, 66, 1)),
      ),
    );

    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(246, 231, 211, 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        width: size.width,
        height: size.height * 0.23,
      ),
      Container(
          margin: EdgeInsets.only(top: 40),
          child: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            iconSize: 40,
            color: Color.fromRGBO(91, 74, 66, 1),
            onPressed: () {
              print('pagina anterior...');
              Navigator.pushNamed(context, 'inicio');
            },
          )),
      buscador,
    ]);
  }

  Widget _lista(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _listarAlumnos(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
              itemBuilder: (BuildContext context, int index) {
                Map alumno = snapshot.data[index];
                return _campoUsuario(
                    context, alumno["nombre"], alumno["numCon"].toString());
              });
        }
      },
    );
  }

  Widget _campoUsuario(BuildContext context, String nombre, String idAlumno) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        width: size.width * 0.8,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Color.fromRGBO(184, 135, 109, 1),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black45.withOpacity(0.19),
                  offset: Offset(0, 10),
                  blurRadius: 4)
            ],
            border:
                Border.all(color: Color.fromRGBO(149, 102, 77, 1), width: 1.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.person,
              color: Colors.white,
              size: 40,
            ),
            Text(nombre, style: TextStyle(color: Colors.white, fontSize: 18)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormAlumno(idAlumno: idAlumno)),
                  );
                },
                icon: Icon(Icons.edit))
            // Text(materia,
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white,
            //         fontSize: 16))
          ],
        ),
      ),
      onTap: () {
        print("papu");
      },
    );
  }

  Widget _botonAgregar(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return FloatingActionButton(
        backgroundColor: Color.fromRGBO(91, 74, 66, 1),
        child: Icon(Icons.add, size: 40),
        onPressed: () {
          Navigator.pushNamed(context, 'formalumnos');
        });
  }
}
