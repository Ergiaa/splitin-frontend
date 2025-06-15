// services/auth_service.dart

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class AuthService {
  final FlutterSecureStorage _storage;
  final String hostname = "10.0.2.2";
  final String port = "5000";
  AuthService(this._storage);

  Future<String?> login(String email, String password) async {
    try {
      final Response response = await post(
        Uri.parse("http://${hostname}:${port}/auth"),
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

  

  // Ini nanti
  // Future<String?> signup(
  //   String name,
  //   String email,
  //   String phone,
  //   String password,
  // ) async {
  //   try {
  //     final response = await _dio.post(
  //       '/register',
  //       data: {
  //         'fullName': name,
  //         'email': email,
  //         'phoneNumber': phone,
  //         'password': password,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       final token = response.data['token'];
  //       await _storage.write(key: 'jwt', value: token);
  //       return token;
  //     }
  //   } catch (e) {
  //     print('Signup error: $e');
  //   }
  //   return null;
  // }
}
