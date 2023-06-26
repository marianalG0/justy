
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchJust extends SearchDelegate {

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
}



  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
     if (query.isEmpty) {
    return Container(); // Retorna un widget vacío si no hay término de búsqueda
  }
  
  return FutureBuilder(
    future: searchByPhoneNumber(query),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasData) {
        // Procesa los datos obtenidos en snapshot.data y muestra los resultados
        return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            final result = snapshot.data![index];
            return ListTile(
              title: Text(result['numControl']),
              subtitle: Text(result['motivo']),
            );
          },
        );
      } else {
        return Center(
          child: Text('No se encontraron resultados'),
        );
      }
    },
  );
}
Future<List<Map<String, dynamic>>> searchByPhoneNumber(String numControl) async {
  String url = "http://192.168.1.71/justy/getjusty.php";

  Map<String, String> headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  Map<String, String> body = {'numControl': numControl};

  http.Response response = await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    // Procesa la respuesta del servidor y devuelve los resultados
    List<dynamic> data = jsonDecode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Error al realizar la búsqueda: ${response.statusCode}');
  }
}
}