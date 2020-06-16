import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/core/utils/graphql/queries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

void main() {
  group('queries', () {
    group('getEvents', () {
      test('returns the right query when getting all of fields', () {
        final query = getEvents(
          id: true,
          title: true,
          description: true,
          price: true,
          date: true,
          creator: true,
        );

        final expectedQuery =
            'query{events{_id,title,description,price,date,creator{email}}}';

        expect(query, expectedQuery);
      });

      test('returns the right query when getting some of fields', () {
        final query1 = getEvents(
          id: true,
          description: true,
          date: true,
        );

        final expectedQuery1 = 'query{events{_id,description,date}}';

        expect(query1, expectedQuery1);

        final query2 = getEvents(
          description: true,
          date: true,
        );

        final expectedQuery2 = 'query{events{description,date}}';

        expect(query2, expectedQuery2);

        final query3 = getEvents(
          id: true
        );

        final expectedQuery3 = 'query{events{_id}}';

        expect(query3, expectedQuery3);

        final query4 = getEvents(
          creator: true,
        );

        final expectedQuery4 = 'query{events{creator{email}}}';

        expect(query4, expectedQuery4);
      });

      test('throws EmptyQueryException when calling the method with no argument', (){
        expect(() => getEvents(), throwsA(TypeMatcher<EmptyQueryException>()));
      });
    });
    group('getBookings', () {
      test('returns the right query when getting all of fields', () {
        final query = getBookings(
          id: true,
          user: true,
          event: true,
          createdAt: true,
          updatedAt: true,
        );

        final expectedQuery =
            'query{bookings{_id,event{_id},user{_id},createdAt,updatedAt}}';

        expect(query, expectedQuery);
      });

      test('returns the right query when getting some of fields', () {
        final query1 = getBookings(
          id: true,
          user: true,
          updatedAt: true,
        );

        final expectedQuery1 = 'query{bookings{_id,user{_id},updatedAt}}';

        expect(query1, expectedQuery1);

        final query2 = getBookings(
          user: true,
          createdAt: true,
        );

        final expectedQuery2 = 'query{bookings{user{_id},createdAt}}';

        expect(query2, expectedQuery2);

        final query3 = getBookings(
          id: true,
        );

        final expectedQuery3 = 'query{bookings{_id}}';

        expect(query3, expectedQuery3);

        final query4 = getBookings(
          event: true,
        );

        final expectedQuery4 = 'query{bookings{event{_id}}}';

        expect(query4, expectedQuery4);
      });

      test('throws EmptyQueryException when calling the method with no argument', (){
        expect(() => getBookings(), throwsA(TypeMatcher<EmptyQueryException>()));
      });
    });
  });
}
