import 'attendance_infrustructure.dart';

class AttendanceRepository {
  final RemoteAttendanceProvider attendaneProvider;

  AttendanceRepository(this.attendaneProvider);

  Future<void> createAttendance(
      String token, int id, Attendance attendance) async {
    return attendaneProvider.createAttendance(token, id, attendance);
  }

  Future<Attendance> getTodaysAttendanceOfUser(String token, int id) async {
    final res = attendaneProvider.getTodaysAttendanceOfUser(token, id);
    return attendaneProvider.getTodaysAttendanceOfUser(token, id);
  }

  Future<List<Attendance>> getAttendanceHistoryOfUser(
      String token, int id) async {
    return attendaneProvider.getAttendanceHistoryOfUser(token, id);
  }

  //this will be used for the manager to approve or to delete an attendance of the user
  Future<List<AttendanceList>> getTodayAttendanceOfAllUsers(
      String token, String date) async {
    return attendaneProvider.getTodayAttendanceOfAllUsers(token, date);
  }

  Future<Attendance> updateAttendance(
      String token, int id, bool present) async {
    final res = attendaneProvider.updateAttendance(token, id, present);
    return attendaneProvider.updateAttendance(token, id, present);
  }

  Future<void> deleteAttendance(String token, int id) async {
    return attendaneProvider.deleteAttendance(token, id);
  }

  Future<void> deleteAttendanceHistoryOfUser(String token, int id) async {
    return attendaneProvider.deleteAttendanceHistoryOfUser(token, id);
  }
}
