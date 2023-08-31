import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:employee_management_system/presentation/presentation_index.dart';

class RemoteAttendanceProvider {
  static const String _baseUrl = "http://localhost:8080/api/attendances";
  final String extend = "user";
  final String attendance = "attendance";

  Future<void> createAttendance(
      String token, int id, Attendance attendance) async {
    final res = await http.post(Uri.parse("$_baseUrl/$extend/$id"),
        headers: <String, String>{
          "Content-Type": "application/json;charSet=UTF-8",
          "Access-Control-Allow-Headers": "X-Requested-With,content-type",
          "x-access-token": token
        },
        body: jsonEncode({
          "date": attendance.date,
          "present": attendance.present,
        }));
    if (res.statusCode == 201) {
      return;
    } else {
      throw Exception("Failed to create attendance");
    }
  }

  Future<List<AttendanceList>> getTodayAttendanceOfAllUsers(
      String token, String date) async {
    final res = await http.post(Uri.parse("$_baseUrl/$attendance"),
        headers: <String, String>{
          "Content-Type": "application/json;charSet=UTF-8",
          "Access-Control-Allow-Headers": "X-Requested-With,content-type",
          "x-access-token": token
        });
    if (res.statusCode == 201) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to create attendance");
    }
  }

  Future<Attendance> getTodaysAttendanceOfUser(String token, int id) async {
    final res = await http
        .get(Uri.parse("$_baseUrl/$extend/$id"), headers: <String, String>{
      "Content-Type": "application/json;charSet=UTF-8",
      "Access-Control-Allow-Headers": "X-Requested-With,content-type",
      "x-access-token": token
    });
    if (res.statusCode == 200) {
      return Attendance.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to get today's attendance of the user");
    }
  }

  Future<List<Attendance>> getAttendanceHistoryOfUser(
      String token, int id) async {
    final res = await http.get(
      Uri.parse("$_baseUrl/$id"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type",
        "x-access-token": token
      },
    );
    if (res.statusCode == 200) {
      final attendances = jsonDecode(res.body) as List;
      return attendances.map((user) => Attendance.fromJson(user)).toList();
    } else {
      throw Exception("Failed to fetch attendance history of the user");
    }
  }

  //updates a specific attendance and return the attendance itself
  Future<Attendance> updateAttendance(
      String token, int id, bool present) async {
    final res = await http.put(
      Uri.parse("$_baseUrl/$attendance/$id"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type",
        "x-access-token": token
      },
      body: jsonEncode({
        "present": present,
      }),
    );
    if (res.statusCode == 200) {
      return Attendance.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to update attendance");
    }
  }

  Future<void> deleteAttendance(String token, int id) async {
    final res = await http.delete(
      Uri.parse("$_baseUrl/$attendance/$id"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type",
        "x-access-token": token
      },
    );
    if (res.statusCode == 200) {
      return;
    } else {
      throw Exception("Failed to delete attendance");
    }
  }

  Future<void> deleteAttendanceHistoryOfUser(String token, int id) async {
    final res = await http.delete(
      Uri.parse("$_baseUrl/$id"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type",
        "x-access-token": token
      },
    );
    if (res.statusCode == 200) {
      return;
    } else {
      throw Exception("Failed to delete attendance");
    }
  }
}
