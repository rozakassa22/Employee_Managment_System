class AttendanceList {
  final int id;
  final String email;
  final bool present;

  AttendanceList({
    required this.id,
    required this.email,
    required this.present,
  });

  factory AttendanceList.fromJson(Map<String, dynamic> json) {
    return AttendanceList(
      id: json['id'],
      email: json['date'],
      present: json['present'],
    );
  }
}