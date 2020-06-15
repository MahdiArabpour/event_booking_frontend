import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../core/errors/exceptions.dart';

abstract class GraphQl {
  /// Sends a post request to the graphql server with the given body as request body
  /// and given token as 'Authorization' request header and if request was successful,
  /// returns result body as [String], Otherwise throws a [ServerException]!
  Future<Map<String, dynamic>> send(String body, {String token = ''});
}

class GraphQlImpl implements GraphQl {
  final http.Client client;
  final InternetAddress internetAddress;
  final String url;

  GraphQlImpl( {
    @required this.client,
    @required this.internetAddress,
    @required this.url,
  });

  @override
  send(String body, {String token = ''}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      final thereIsInternetConnection =
          result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      if (thereIsInternetConnection) {
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

        final jsonResult = json.decode(response.body);

        final errors = jsonResult['errors'];
        final thereAreErrors = errors != null;
        final isSuccessful = jsonResult['data'] != null && !thereAreErrors;

        if (isSuccessful) {
          return jsonResult;
        }

        if (thereAreErrors) {
          List<String> messages = errors
              .map((error) {
                return error['message'];
              })
              .cast<String>()
              .toList();
          throw ServerException(messages: messages);
        }

        throw UnknownServerException();
      }

      throw SocketException('There is no internet connection');
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }
}
