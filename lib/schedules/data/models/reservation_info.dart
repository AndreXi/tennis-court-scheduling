class ReservationInfo {
  const ReservationInfo({
    required this.userName,
    required this.courtName,
    required this.date,
  });

  final String userName;
  final String courtName;
  final String date;

  @override
  String toString() => '''
ReservationInfo(userName: $userName, courtName: $courtName, date: $date)''';
}
