import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:justy_app/src/pages/inicio_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  Future login() async {
    var url = Uri.parse("http://192.168.1.100/justy/login.php");
    final response = await http.post(url, body: {
      "username": controllerUser.text,
      "password": controllerPass.text,
    });
    final data = json.decode(response.body);

    if (data == "Success") {
      Fluttertoast.showToast(
        msg: 'Usted ingreso correctamente',
        fontSize: 10,
        textColor: Colors.green,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaginaInit(),
        ),
      );
    } else {
      Fluttertoast.showToast(
          msg: 'Su username o password son incorrectos',
          fontSize: 10,
          textColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backgroungIni.png'),
              fit: BoxFit.cover)),
      child: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: Container(
                    height: 40.0,
                  ),
                ),
                Container(
                  width: size.width * 0.85,
                  margin: EdgeInsets.symmetric(vertical: 30.0),
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Column(
                    children: <Widget>[
                      Text('Ingresar',
                          style: TextStyle(
                            fontSize: 45.0,
                            color: Color.fromRGBO(91, 74, 66, 1),
                          )),
                      SizedBox(height: 120.0),
                      _labelCuenta(),
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  color: Colors
                                      .black45, //numeros el indice de opacidad
                                  blurRadius: 2.0,
                                  spreadRadius: 1.0,
                                  offset:
                                      Offset(2.0, 5.0) //posicion de la sombra
                                  )
                            ]),
                        child: TextField(
                          controller: controllerUser,
                          decoration: InputDecoration(
                            hintText: 'usuario',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _labelContra(),
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  color: Colors
                                      .black45, //numeros el indice de opacidad
                                  blurRadius: 2.0,
                                  spreadRadius: 1.0,
                                  offset:
                                      Offset(2.0, 5.0) //posicion de la sombra
                                  )
                            ]),
                        child: TextField(
                          controller: controllerPass,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Contraseña',
                            //counterText: snapshot.data,
                            //errorText: snapshot.error
                          ),
                          //onChanged: bloc.changePassword,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, 'registro'),
                          child: Text(
                            '¿Aún no tienes una cuenta?, Créalo Aquí',
                            style:
                                TextStyle(color: Color.fromRGBO(91, 74, 66, 1)),
                          )),
                      SizedBox(height: 6.0),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 80.0, vertical: 15.0),
                          child: Text('Ingresar'),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color.fromRGBO(184, 135, 109, 1),
                        ),
                        onPressed: () {
                          login();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

Widget _labelCuenta() {
  return Padding(
    padding: const EdgeInsets.only(left: 11),
    child: Row(
      children: [
        Text(
          'Usuario',
          style: TextStyle(color: Color.fromRGBO(91, 74, 66, 1)),
          textAlign: TextAlign.start,
        ),
      ],
    ),
  );
}

Widget _labelContra() {
  return Padding(
    padding: const EdgeInsets.only(left: 11),
    child: Row(
      children: [
        Text(
          'Contraseña',
          style: TextStyle(color: Color.fromRGBO(91, 74, 66, 1)),
          textAlign: TextAlign.start,
        ),
      ],
    ),
  );
}
