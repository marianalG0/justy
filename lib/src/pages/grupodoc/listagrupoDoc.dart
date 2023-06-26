import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'formgrupoDoc.dart';

class ListaGrupodoc extends StatefulWidget {
  @override
  State<ListaGrupodoc> createState() => _ListaGrupodocState();
}

class _ListaGrupodocState extends State<ListaGrupodoc> {
  Future getData() async {
    var url = Uri.parse("http://192.168.1.8/justy/leergrupd.php");
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(91, 74, 66, 1),
          child: Icon(Icons.add, size: 40),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => formgd(),
              ),
            );
          }),
      body: Column(
        children: [
          _appBar(context),
          Expanded(
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          List list = snapshot.data;
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 12),
                            height: 70,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(184, 135, 109, 1),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black45.withOpacity(0.19),
                                      offset: Offset(0, 10),
                                      blurRadius: 4)
                                ],
                                border: Border.all(
                                    color: Color.fromRGBO(149, 102, 77, 1),
                                    width: 1.5)),
                            child: Center(
                              child: ListTile(
                                title: Text(
                                  list[index]['nomenclatura'],
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                subtitle: Text(
                                  list[index]['idDoc'],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        })
                    : Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Cargando...',
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Color.fromARGB(255, 82, 74, 38)),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
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
              Navigator.pop(context);
            },
          )),
      buscador,
    ]);
  }
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
          hintText: 'Buscar docente',
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
            Navigator.pop(context);
          },
        )),
    buscador,
  ]);
}
