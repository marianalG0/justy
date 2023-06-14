import 'package:flutter/material.dart';

class JustificacionesLista extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            _appBar(context),
            Expanded(child: _lista(context)),
          ]
        ),
        floatingActionButton: _botonAgregar(context),
      );
  }

  Widget _appBar(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final buscador = Container(
      margin: EdgeInsets.only(
        top: size.height*0.12,
        left: size.width*0.08
      ),
      width: size.width*0.85,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide.none
          ),
          hintText: 'Buscar alumno',
          suffixIcon: Icon(Icons.search),
          suffixIconColor: Color.fromRGBO(149, 102, 77, 1)
        ),
      ),
    );

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(1149, 102, 77, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40)
            )
          ),
          width: size.width,
          height: size.height*0.23,
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          child: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            iconSize: 40,
            color: Color.fromRGBO(149, 102, 77, 1),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ),
        buscador,
      ]
    );
  }

  Widget _lista(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
        children: [
          Divider(),
          _campoJusti(),
          Divider(),
           _campoJusti(),
          Divider(),
           _campoJusti(),
          Divider(),
          _campoJusti(),
          Divider(),
          _campoJusti(),
          Divider(),
          _campoJusti(),
          Divider(),

         
        ],
      );
  }

  Widget _campoJusti() {
    
    return Container(padding: EdgeInsets.all(20.0),decoration: 
    BoxDecoration(  border: Border.all(color: Color.fromRGBO(88, 56, 41, 1)), borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Color.fromRGBO(246, 231, 211, 1)), child: Column(
      children: [
       Row(children: [Text('Estimados maestros del aula: 3     '),
      Text('Semestre: VI'), ],) ,
      Text('Fecha: 18-06-2005'), 
      Text('De la carrera de: Programación'), 
      Text('Por este medio solicito a usted (es) sea tan amable (s) de justificar la inasistencia del'), 
      Text('Alumno: Edward Aldayr Lopez Zapata'), 
      Text('El (los) día (s): 15 de Junio'), 
      Text('A partir de: 8:00 a 11:00 hrs.'), 
      Text('Del año en curso, por motivos de: Gripe simia'), 
      Text('(Familiar, Académico, Salud, Uniforme, Personal)', style: TextStyle(fontSize: 13),)]));
  }

  Widget _botonAgregar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FloatingActionButton(
      backgroundColor: Color.fromRGBO(91, 74, 66, 1),
      child: Icon(Icons.add, size: 40),
      onPressed: (){
         Navigator.pushNamed(context, 'formalumnos');
      }
    );
  }
}