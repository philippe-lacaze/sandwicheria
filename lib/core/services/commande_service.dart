import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sandwicheria/core/models/commande.dart';

class CommandeService {
  static const _endpoint = 'http://localhost:8080/api/commande';
  static Map<String, String> _headers = {'Content-Type': 'application/json'};

  var client = new http.Client();

  Future<List<Commande>> fetchAll() async {
    var response = await client.get(_endpoint);

    print('CommandeService response = ${response.body}');
    return commandesFromJson(response.body);
  }

  Future<Commande> update(Commande commande) async {
    print('put commande before $commande');
    var body = json.encode(commande.toJson());
    var response = await client.put(_endpoint, body: body, headers: _headers);
    print('put commande response body ${response.body}');
    return Commande.fromJson(json.decode(response.body));
  }

//  Stream<Commande> fetchSSE() {
//    var sseClient = SseClient(_endpoint + '/message');
//    return sseClient.stream.map((data) {
//      print('SSE data=$data');
//      return Commande.fromJson(jsonDecode(data));
//    });
//  }
}
