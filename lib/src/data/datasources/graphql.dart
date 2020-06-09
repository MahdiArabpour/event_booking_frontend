import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../core/errors/exceptions.dart';

abstract class GraphQl {

  /// Sends a post request to the graphql server with the given body as request body
  /// and given token as 'Authorization' request header and if request was successful,
  /// returns result body as [String], Otherwise throws a [ServerException]!
  Future<Map<String,dynamic>> send(String body, {String token = ''});
}

const url = 'http://192.168.43.231:3000/graphql';

class GraphQlImpl implements GraphQl{
  final http.Client client;

  GraphQlImpl({
    @required this.client,
  });

  @override
  send(String body, {String token = ''}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final postBody = {
      'query': body,
    };

    final response = await client.post(
      url,
      headers: headers,
      body: json.encode(postBody),
    );

    final isSuccessful = response.statusCode == 200 || response.statusCode == 201;

    if (isSuccessful) {
      return json.decode(response.body);
    }

    throw ServerException(message: response.body);
  }

}
