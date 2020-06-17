import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/src/data/datasources/graphql.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  GraphQl graphQl;
  MockHttpClient httpClient;
  String url = 'https://event-booking-graphql.herokuapp.com/graphql';

  setUp(() {
    httpClient = MockHttpClient();
    graphQl = GraphQlImpl(
      client: httpClient,
      url: url,
    );
  });

  group('GraphQl query', () {
    final requestQuery = 'query{events{title}}';
    final responseBody = """
      {
        "data": {
          "events": [
            {
              "title": "Testing"
            },
            {
              "title": "Testing again"
            }
          ]
        }
      }
    """;

    test(
      'Performs a POST request on a graphql URL with the right body',
      () async {
        when(httpClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer(
                (realInvocation) async => http.Response(responseBody, 200));

        await graphQl.send(requestQuery);

        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ',
        };

        final body = {
          'query': requestQuery,
        };

        verify(httpClient.post(url, headers: headers, body: json.encode(body)));
      },
    );

    test(
      'Returns the right json string when the status code is 200 ok',
      () async {
        when(httpClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer(
                (realInvocation) async => http.Response(responseBody, 200));

        final result = await graphQl.send(requestQuery);

        expect(result, equals(json.decode(responseBody)));
      },
    );

    test(
      'Throws a ServerException when the response contains error',
      () async {
        when(httpClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((realInvocation) async => http.Response("""
{
  "errors": [
    {
      "message": "User does not exist",
      "locations": [
        {
          "line": 2,
          "column": 3
        }
      ],
      "path": [
        "login"
      ]
    }
  ],
  "data": null
}
                """, 200));

        expect(() => graphQl.send(requestQuery),
            throwsA(TypeMatcher<ServerException>()));
      },
    );

    test(
      'Throws an UnknownServerException when the response contains unknown error',
      () async {
        when(httpClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((realInvocation) async =>
                http.Response('{"error":"Some unknown error"}', 200));

        expect(() => graphQl.send(requestQuery),
            throwsA(TypeMatcher<UnknownServerException>()));
      },
    );
  });
}
