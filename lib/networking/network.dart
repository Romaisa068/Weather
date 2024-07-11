// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  Network(this.url);
  // ignore: prefer_typing_uninitialized_variables
  late final url;

  Future getData() async {
    final headers = {
      'x-rapidapi-host':' open-weather13.p.rapidapi.com',
      'x-rapidapi-key' :'  8eb00ff556msh52333480e9a015dp1da477jsn9ff2eb3dfd5a'
    };

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
