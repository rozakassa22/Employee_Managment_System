// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';

import 'package:employee_management_system/domain/auth/user_model.dart';

import '../infrastructure_index.dart';
import 'package:http/http.dart' as http;

class RemoteProfileProvider {
  static const String _baseUrl = "http://localhost:8080/api/profiles";

  Future<List<User>> getAllUsersProfile(String token, int id) async {
    final res = await http.get(
      Uri.parse("$_baseUrl"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type",
        "x-access-token": token
      },
    );
    if (res.statusCode == 200) {
      final users = jsonDecode(res.body) as List;
      return users.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception("Failed to fetch users");
    }
  }

  Future<User> getUserProfile(String token, int id) async {
    final res = await http.get(
      Uri.parse("$_baseUrl/$id"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type",
        "x-access-token": token
      },
    );
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to fetch users");
    }
  }

  Future<void> updateUserProfile(User user, String token) async {
    final res = await http.put(
      Uri.parse("$_baseUrl/${user.id}"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type",
        "x-access-token": token
      },
      body: jsonEncode({
        "email": user.email,
        "password": user.password,
      }),
    );
    if (res.statusCode == 200) {
      return;
    } else {
      throw Exception("Failed to update user");
    }
  }

  Future<bool> deleteUserProfile(String token, int id) async {
    final res = await http.delete(
      Uri.parse("$_baseUrl/$id"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type",
        "x-access-token": token
      },
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete user");
    }
  }

  Future<bool> revokeUserRole(String token, int id, String role) async {
    try {
      final res = await http.put(
        Uri.parse("$_baseUrl/$id"),
        headers: <String, String>{
          "Content-Type": "application/json;charSet=UTF-8",
          "Access-Control-Allow-Headers": "X-Requested-With,content-type",
          "x-access-token": token
        },
        body: jsonEncode({"role": role == "manager" ? "employee" : "manager"}),
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw Exception("Failed to revoke user role");
    }
  }
}
