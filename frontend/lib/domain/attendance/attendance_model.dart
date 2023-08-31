class Attendance {
  final int? id;
  final String date;
  final bool present;

  Attendance({
    this.id,
    required this.date,
    required this.present,

  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      date: json['date'],
      present: json['present'],
    );
  }
}
