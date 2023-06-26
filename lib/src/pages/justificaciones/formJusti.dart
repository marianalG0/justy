import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:searchfield/searchfield.dart';

import '../inicio_page.dart';
import '../notifications.dart';

class formJusty extends StatefulWidget {
//lista

  final List? list;
  final int? index;
  formJusty({this.list, this.index});
  @override
  _formJustyState createState() => _formJustyState();
}

class _formJustyState extends State<formJusty> {
  String _fecha = '';
  String _hora = '';
  List alumItemList = [];
  List group = [];

  //conexion a la base de datos para mostrarlo inicio codigo
  Future getAllData() async {
    var url = Uri.parse("http://192.168.20.74/justy/leeralum.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        alumItemList = jsonData;
      });
    }
    print(alumItemList);
  }

  //conexion a la base de datos para mostrarlo inicio codigo
  Future getAllGroup() async {
    var url = Uri.parse("http://192.168.20.74/justy/leergrupd.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        group = jsonData;
      });
    }
    print(group);
  }

  String? selectedValue;
  String? selectedValue2;
//CONTROLADORES
  //TextEditingController numControl = TextEditingController();
  //TextEditingController grupo = TextEditingController();
  TextEditingController motivo = TextEditingController();
  TextEditingController otroMotivo = TextEditingController();
  TextEditingController fechaInicial = TextEditingController();
  TextEditingController fechaFinal = TextEditingController();
  TextEditingController horaInicial =  TextEditingController();
  TextEditingController horaFinal =TextEditingController();

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      //para editar uno existente
      var url = Uri.parse("http://192.168.20.74/justy/editarjusti.php");
      http.post(url, body: {
        'idJusty':widget.list![widget.index!]['idJusty'],
        'numControl': selectedValue,
        'idGrupoDoc': selectedValue2,
        'fechaInicio': fechaInicial.text,
        'fechaFinal': fechaFinal.text,
        'horaInicio': horaInicial.text,
        'horaFinal': horaFinal.text,
        'motivo': motivo.text,
      });
    } else {
      //para agregar uno
      var url = Uri.parse("http://192.168.20.74/justy/agregarjusti.php");
      http.post(url, body: {
        'numControl': selectedValue,
        'idGrupoDoc': selectedValue2,
        'fechaInicio': fechaInicial.text,
        'fechaFinal': fechaFinal.text,
        'horaInicio': horaInicial.text,
        'horaFinal': horaFinal.text,
        'motivo': motivo.text,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllData();
    getAllGroup();

    if (widget.index != null) {
      editMode = true;
      fechaInicial.text = widget.list![widget.index!]['fechaInicio'];
      fechaFinal.text = widget.list![widget.index!]['fechaFinal'];
      horaInicial.text = widget.list![widget.index!]['horaInicio'];
      horaFinal.text = widget.list![widget.index!]['fechaFinal'];
      motivo.text = widget.list![widget.index!]['motivo'];
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
                    //CAMPOOOOOO
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Número de control',
                          style: TextStyle(
                              color: Color(0xFFFF5B4A42),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text('Selecciona el alumno'),
                            value: selectedValue,
                            items: alumItemList.map((numCon) {
                              return DropdownMenuItem(
                                  value: numCon['numControl'],
                                  child: Text(numCon['numControl']));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    //para grupo
                    Row(
                      children: <Widget>[
                        //  const Icon(Icons.border_color),
                        const SizedBox(width: 30.0),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text('Selecciona al grupo'),
                            value: selectedValue2,
                            items: group.map((group) {
                              return DropdownMenuItem(
                                  value: group['idgrupoDoc'],
                                  child: Text(group['nomenclatura']));
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Fecha inicio',
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
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.calendar_month,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              hintText: 'Seleccione la fecha',
                              enabledBorder: borde(),
                              focusedBorder: borde()),
                          enableInteractiveSelection: false,
                          controller: fechaInicial,
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            _selectDate(context);
                          },
                        ),
                      ],
                    ),

                    /////////////////////campo
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Fecha final',
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
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.calendar_month,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              hintText: 'Seleccione la fecha',
                              enabledBorder: borde(),
                              focusedBorder: borde()),
                          enableInteractiveSelection: false,
                          controller: fechaFinal,
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            _selectDateFinal(context);
                          },
                        ),
                      ],
                    ),

                    //CAMPOOOOOOO
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Hora inicio',
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
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.access_time_outlined,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              hintText: 'seleccione la hora',
                              enabledBorder: borde(),
                              focusedBorder: borde()),
                          enableInteractiveSelection: false,
                          controller: horaInicial,
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            _selectTime(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Hora final',
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
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.access_time_outlined,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              hintText: 'Selecciona la hora',
                              enabledBorder: borde(),
                              focusedBorder: borde()),
                          enableInteractiveSelection: false,
                          controller: horaFinal,
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            _selectTimeFinal(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Motivo',
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
                          controller: motivo,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.edit_document,
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
                            mostrarNotificacion();
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

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2025),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fecha = picked.toString();
        // hace que de acuerdo a lo que pongamos el controlador lo tomara y lo enviara a la caja de texto,
        // de esta forma nos muestra la fecha
        fechaInicial.text = _fecha;
      });
    }
  }

  _selectDateFinal(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2025),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fecha = picked.toString();
        // hace que de acuerdo a lo que pongamos el controlador lo tomara y lo enviara a la caja de texto,
        // de esta forma nos muestra la fecha
        fechaFinal.text = _fecha;
      });
    }
  }

  _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: new TimeOfDay.now());

    if (picked != null) {
      setState(() {
        _hora = picked.toString();
        // hace que de acuerdo a lo que pongamos el controlador lo tomara y lo enviara a la caja de texto,
        // de esta forma nos muestra la fecha
        horaInicial.text = _hora;
      });
    }
  }

  _selectTimeFinal(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: new TimeOfDay.now());

    if (picked != null) {
      setState(() {
        _hora = picked.toString();
        // hace que de acuerdo a lo que pongamos el controlador lo tomara y lo enviara a la caja de texto,
        // de esta forma nos muestra la fecha
        horaFinal.text = _hora;
      });
    }
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
