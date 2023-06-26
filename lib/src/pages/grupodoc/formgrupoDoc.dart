import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../inicio_page.dart';

class formgd extends StatefulWidget {
//lista
  final List? list;
  final int? index;
  formgd({this.list, this.index});
  @override
  _formgdState createState() => _formgdState();
}

class _formgdState extends State<formgd> {
  List grupoItemList = [];
  List docentes = [];

  //conexion a la base de datos para mostrarlo inicio codigo
  Future getAllgrupo() async {
    var url = Uri.parse("http://192.168.1.8/justy/leergrupo.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        grupoItemList = jsonData;
      });
    }
    print(grupoItemList);
  }

  //conexion a la base de datos para mostrarlo inicio codigo
  Future getAllperson() async {
    var url = Uri.parse("http://192.168.1.8/justy/leedoc.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        docentes = jsonData;
      });
    }
    print(docentes);
  }

  String? selectedValue;
  String? selectedValue2;
//CONTROLADORES

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      //para editar uno existente
      var url = Uri.parse("http://192.168.1.8/justy/editargrupodoc.php");
      http.post(url, body: {
        'idgrupoDoc': widget.list![widget.index!]['idgrupoDoc'],
        'idGrupo': selectedValue,
        'idDoc': selectedValue2,
      });
    } else {
      //para agregar uno
      var url = Uri.parse("http://192.168.1.8/justy/agregargrupodoc.php");
      http.post(url, body: {
        'idGrupo': selectedValue,
        'idDoc': selectedValue2,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllgrupo();
    getAllperson();

    if (widget.index != null) {
      editMode = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.only(top: 230),
              child: Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    //Para persona
                    Row(
                      children: <Widget>[
                        //  const Icon(Icons.border_color),
                        const SizedBox(width: 30.0),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text('Selecciona el grupo'),
                            value: selectedValue,
                            items: grupoItemList.map((grupo) {
                              return DropdownMenuItem(
                                  value: grupo['nomenclatura'],
                                  child: Text(grupo['nomenclatura']));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                          ),
                        )
                      ],
                    ),

                    //para grupo
                    Row(
                      children: <Widget>[
                        //  const Icon(Icons.border_color),
                        const SizedBox(width: 30.0),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text('Selecciona el docente'),
                            value: selectedValue2,
                            items: docentes.map((docentes) {
                              return DropdownMenuItem(
                                  value: docentes['idDoc'],
                                  child: Text(docentes['nombre']));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue2 = value.toString();
                              });
                            },
                          ),
                        )
                      ],
                    ),

                    //Campoooo0000

                    SizedBox(
                      height: 15,
                    ),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 80.0, vertical: 15.0),
                          elevation: 0.0,
                          backgroundColor: Color(0xFFFFB8876D),
                        ),
                        onPressed: () {
                          setState(() {
                            addUpdateData();
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaginaInit(),
                            ),
                          );
                          debugPrint('hizo click');
                        },
                        child: Text(
                          editMode ? 'Actualizar' : 'Guardar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Regresar',
                          style:
                              TextStyle(color: Color.fromRGBO(91, 74, 66, 1)),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    final fondo = Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/fondoForm.png'), fit: BoxFit.cover),
          color: Color(0xFFFF6E7D3),
          borderRadius: BorderRadius.circular(30.0)),
    );

    return Stack(
      children: <Widget>[
        fondo,
        Container(
          child: Column(
            children: <Widget>[
              Image.asset('assets/fondoAlum.png'),
            ],
          ),
        )
      ],
    );
  }

  OutlineInputBorder borde() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
          color: Color(0xFFFF5B4A42),
          width: 1.5,
        ));
  }
}
