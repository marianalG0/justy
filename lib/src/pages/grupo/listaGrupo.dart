import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'formGrupo.dart';

class listGrupo extends StatefulWidget {
  @override
  State<listGrupo> createState() => _listGrupoState();
}

class _listGrupoState extends State<listGrupo> {
  Future getData() async {
    var url = Uri.parse("http://192.168.20.74/justy/leergrupo.php");
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
                builder: (context) => FormGrupo(),
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
                                      builder: (context) => FormGrupo(
                                        list: list,
                                        index: index,
                                      ),
                                    ),
                                  );
                                  debugPrint('Edit Clicked');
                                },
                              ),
                              title: Text(list[index]['nomenclatura'],style: TextStyle(color: Colors.white),),
                              subtitle: Text(list[index]['aula']),
                              trailing: GestureDetector(
                                child: Icon(Icons.delete),
                                onTap: () {
                                  setState(() {
                                    var url = Uri.parse(
                                        "http://192.168.20.74/justy/borrargrup.php");
                                    http.post(url, body: {
                                      'nomenclatura': list[index]['nomenclatura'],
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

    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(246, 231, 211, 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        width: size.width,
        height: size.height * 0.2,
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
  
    ]);
  }
}

