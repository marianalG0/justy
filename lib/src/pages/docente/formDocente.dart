import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../inicio_page.dart';
import 'listaDocente.dart';

class FormDocente extends StatefulWidget {
  final List? list;
  final int? index;
  FormDocente({this.list, this.index});
  @override
  _FromDocenteState createState() => _FromDocenteState();
}

class _FromDocenteState extends State<FormDocente> {
//CONTROLADORES
  TextEditingController materia = TextEditingController();
  TextEditingController per = TextEditingController();

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      //para editar uno existente
      var url = Uri.parse("http:// 192.168.0.189/justy/editarperson.php");
      http.post(url, body: {
        'idDoc': widget.list![widget.index!]['idDoc'],
        'materia': materia.text,
        'per': per.text
      });
    } else {
      //para agregar uno
      var url = Uri.parse("http:// 192.168.0.189/justy/agregarperson.php");
      http.post(url, body: {
       'materia': materia.text,
        'per': per.text,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
    materia.text = widget.list![widget.index!]['materia'];
      per.text = widget.list![widget.index!]['per'];
     

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFoondo(context),
          _crearFondo(context),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.only(top: 230),
              child: Expanded(
                child: ListView(
                  children: <Widget>[
                    //CAMPOOOOOO
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Materias',
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

                    //Campoooo0000

                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Persona',
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
                          controller: per,
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
                          debugPrint('Clicked RaisedButton Button');
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
  Widget _crearFoondo(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    final fondo = Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/fondo.png'), fit: BoxFit.cover),
          color: Color(0xFFFF6E7D3),
          borderRadius: BorderRadius.circular(50.0)),
    );

    return Stack(
      children: <Widget>[
        fondo,
        Container(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              Image.asset('assets/docente.png'),
            ],
          ),
        )
      ],
    );
  }

 