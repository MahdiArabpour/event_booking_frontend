import 'dart:convert';

import 'package:event_booking/core/error/exceptions.dart';
import 'package:event_booking/data/datasources/graphql.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  GraphQl graphQl;
  MockHttpClient httpClient;
  String url = 'http://localhost:3000/graphql';

  setUp(() {
    httpClient = MockHttpClient();
    graphQl = GraphQlImpl(client: httpClient);
  });

  group('GraphQl query', () {
    test(
      'Performs a POST request on a graphql URL with the right body',
      () async {
        final requestQuery = 'query{events{title}}';
        final responseBody = '"data":{"test":"test"}';

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
        final requestQuery = 'query{events{title}}';
        final responseBody = '"data":{"test":"test"}';
        when(httpClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer(
                (realInvocation) async => http.Response(responseBody, 200));

        String result = await graphQl.send(requestQuery);

        expect(result, equals(responseBody));
      },
    );

    test(
      'Throws a ServerException when the status code is not 200',
      () async {
        final requestQuery = 'query{events{title}}';
        when(httpClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer(
                (realInvocation) async => http.Response('Unsupported Media Type', 415));

        expect(() => graphQl.send(requestQuery), throwsA( const TypeMatcher<ServerException>() ));
      },
    );
  });
}
