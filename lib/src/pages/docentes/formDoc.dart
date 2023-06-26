import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../inicio_page.dart';


class formDoc extends StatefulWidget {
//lista
  final List? list;
  final int? index;
  formDoc({this.list, this.index});
  @override
  _formDocState createState() => _formDocState();
}

class _formDocState extends State<formDoc> {
 
  List persona = [];

  

  //conexion a la base de datos para mostrarlo inicio codigo
  Future getAllperson() async {
    var url = Uri.parse("http://192.168.1.71/justy/leerperson.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        persona = jsonData;
      });
    }
    print(persona);
  }



//CONTROLADORES
  TextEditingController materia = TextEditingController();

  bool editMode = false;

String? selectedValue;

  addUpdateData() {
    if (editMode) {
      //para editar uno existente
      var url = Uri.parse("http://192.168.1.71/justy/editardoc.php");
      http.post(url, body: {
        'idDoc': widget.list![widget.index!]['idDoc'],
        'materia': materia.text,
        'idPersona': selectedValue,
      });
    } else {
      //para agregar uno
      var url = Uri.parse("http://192.168.1.71/justy/agregardoc.php");
      http.post(url, body: {
        'materia': materia.text,
        'idPersona': selectedValue
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getAllperson();

    if (widget.index != null) {
      editMode = true;
      materia.text = widget.list?[widget.index!]['materia'];
 
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
                  
                    //para grupo
                    Row(
                      children: <Widget>[
                        //  const Icon(Icons.border_color),
                        const SizedBox(width: 30.0),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text('Selecciona la persona'),
                            value: selectedValue,
                            items: persona.map((persona) {
                              return DropdownMenuItem(
                                  value: persona['idPersona'],
                                  child: Text(persona['nombre']));
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

                    //Campoooo0000

                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Materia',
                          style: TextStyle(
                              color: Color(0xFFFF5B4A42),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: materia,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              hintText: '',
                              enabledBorder: borde(),
                              focusedBorder: borde()),
                        ),
                      ],
                    ),

                  
                    //BOTONEEEES
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
              Image.asset('assets/docente.png'),
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
