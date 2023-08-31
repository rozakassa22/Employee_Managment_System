import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_infrustructure.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  static const String _baseUrl = "http://localhost:8080/api";

  static AuthenticatedUser? authenticatedUser;
  final signup = "create-account";
  final applicants = "applicants";
  final loggedIn = "login";

  Future createAccount(User user) async {
    final http.Response response = await http.post(
      Uri.parse("$_baseUrl/$signup"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type"
      },
      body: jsonEncode({
        "email": user.email,
        "password": user.password,
        "role": user.role,
        "approved": false
      }),
    );
    if (response.statusCode == 201) {
      return;
    } else if (response.statusCode == 500) {
      throw Exception("Serer error! User can't be registered");
    } else {
      throw Exception("Email already in use");
    }
  }

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<AuthenticatedUser?> readUser() async {
    final user = await storage.read(key: 'authenticated_user');
    if (user?.isNotEmpty ?? false) {
      return AuthenticatedUser.fromJson(jsonDecode(user!));
    }
    return null;
  }

  Future<void> persistUser(AuthenticatedUser user) async {
    await storage.write(
        key: 'authenticated_user', value: json.encode(user.toJson()));
  }

  Future<bool> deleteUser() async {
    authenticatedUser = null;
    try {
      await storage.delete(key: 'authenticated_user');
      await storage.deleteAll();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<AuthenticatedUser> login(String email, String password) async {
    final res = await http.post(
      Uri.parse("$_baseUrl/$loggedIn"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type"
      },
      body: jsonEncode({"email": email, "password": password}),
    );
    if (res.statusCode == 200) {
      persistUser(AuthenticatedUser.fromJson(jsonDecode(res.body)));
      authenticatedUser = AuthenticatedUser.fromJson(jsonDecode(res.body));
      return AuthenticatedUser.fromJson(jsonDecode(res.body));
    } else if (res.statusCode == 404) {
      throw Exception("User not found");
    } else if (res.statusCode == 401) {
      throw Exception("Invalid password");
    } else if (res.statusCode == 402) {
      throw Exception("You need an approval from the owner");
    } else {
      throw Exception("Failed to login");
    }
  }

  //This method will try to fetch only applicants that are not yet approved to the owners dashboard
  Future<List<User>> getApplicants() async {
    final res = await http.get(Uri.parse("$_baseUrl/$applicants"));
    if (res.statusCode == 200) {
      final users = jsonDecode(res.body) as List;
      return users.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception("Failed to fetch users");
    }
  }

  //This method will try to update an individual applicants approved status
  Future approveApplicant(int id, User user) async {
    final res = await http.put(
      Uri.parse("$_baseUrl/$applicants/$id"),
      headers: <String, String>{
        "Content-Type": "application/json;charSet=UTF-8",
        "Access-Control-Allow-Headers": "X-Requested-With,content-type"
      },
      body: jsonEncode({
        "email": user.email,
        "password": user.password,
        "role": user.role,
        "approved": true
      }),
    );
    if (res.statusCode == 200) {
      return;
    } else {
      throw Exception("Failed to approve user");
    }
  }

  Future rejectApplicant(int id, User user) async {
    final res = await http.delete(Uri.parse("$_baseUrl/$applicants/$id"),
        headers: <String, String>{
          "Content-Type": "application/json;charSet=UTF-8",
          "Access-Control-Allow-Headers": "X-Requested-With,content-type"
        });

    if (res.statusCode == 200) {
      return;
    } else {
      throw Exception("Failed to reject user");
    }
  }
}
