import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'formPersona.dart';

class listPer extends StatefulWidget {
  @override
  State<listPer> createState() => _listPerState();
}

class _listPerState extends State<listPer> {
  Future getData() async {
    var url = Uri.parse("http:// 192.168.0.189/justy/leerperson.php");
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
                builder: (context) => formPersona(),
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
                            child: ListTile(
                              leading: GestureDetector(
                                child: Icon(Icons.edit),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => formPersona(
                                        list: list,
                                        index: index,
                                      ),
                                    ),
                                  );
                                  debugPrint('Edit Clicked');
                                },
                              ),
                              title: Text(list[index]['nombre']),
                              subtitle: Text(list[index]['telefono']),
                              trailing: GestureDetector(
                                child: Icon(Icons.delete),
                                onTap: () {
                                  setState(() {
                                    var url = Uri.parse(
                                        "http:// 192.168.0.189/justy/borrarperson.php");
                                    http.post(url, body: {
                                      'idPersona': list[index]['idPersona'],
                                    });
                                  });
                                  debugPrint('delete Clicked');
                                },
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
                              style: TextStyle(fontSize: 40, color: Colors.red),
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
