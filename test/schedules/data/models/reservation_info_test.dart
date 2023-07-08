// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_court_scheduling/schedules/schedules.dart';

void main() {
  group('ReservationInfo', () {
    test('toString() devuelve una cadena formateada correctamente', () {
      const reservation = ReservationInfo(
        userName: 'John Doe',
        courtName: 'Court A',
        date: '2023-07-08',
      );
      const expectedString =
          'ReservationInfo(userName: John Doe, courtName: Court A, date: 2023-07-08)';

      expect(reservation.toString(), equals(expectedString));
    });

    test('dos instancias con los mismos valores son iguales', () {
      const reservation1 = ReservationInfo(
        userName: 'John Doe',
        courtName: 'Court A',
        date: '2023-07-08',
      );
      const reservation2 = ReservationInfo(
        userName: 'John Doe',
        courtName: 'Court A',
        date: '2023-07-08',
      );

      expect(reservation1, equals(reservation2));
    });

    test('dos instancias con diferentes valores son diferentes', () {
      const reservation1 = ReservationInfo(
        userName: 'John Doe',
        courtName: 'Court A',
        date: '2023-07-08',
      );
      const reservation2 = ReservationInfo(
        userName: 'Jane Smith',
        courtName: 'Court B',
        date: '2023-07-10',
      );

      expect(reservation1, isNot(equals(reservation2)));
    });
  });
}
