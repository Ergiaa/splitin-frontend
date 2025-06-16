// services/auth_service.dart

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class AuthService {
  final FlutterSecureStorage _storage;
  AuthService(this._storage);

  Future<String?> login(String email, String password) async {
    try {
      final Response response = await post(
        Uri.parse("${dotenv.env["BACKEND_URL"]}/auth"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final token = json['data']['token'];
        await _storage.write(key: 'jwt', value: token);

        return token;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
    return null;
  }

  Future<String?> get getToken async => await _storage.read(key: 'jwt');

  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt');
  }

  // Ini nanti
  Future<bool> signup(String username, String email, String password) async {
    try {
      final response = await post(
        Uri.parse("${dotenv.env["BACKEND_URL"]}/user"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'email': email,
          'password': password,
          'username': username,
        },
      );
      print("Username : ${username}");
      if (response.statusCode == 201) return true;
    } catch (e) {
      print('Signup error: $e');
      return false;
    }
    return false;
  }
}
