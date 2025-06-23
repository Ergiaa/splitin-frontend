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

  Future<int?> signup(String username, String email, String password) async {
    try {
      final response = await post(
        Uri.parse("${dotenv.env["BACKEND_URL"]}/user"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'email': email, 'password': password, 'username': username},
      );
      print("Username : ${username}");
      // if (response.statusCode == 201) return true;
      return response.statusCode;
    } catch (e) {
      print('Signup error: $e');
      return null;
    }
    return null;
  }

  Future<Map> getUserSession() async {
    try {
      String? token = await _storage.read(key: 'jwt');

      if (token != null) {
        String token_header = "Bearer $token";

        Response response = await get(
          Uri.parse("${dotenv.env["BACKEND_URL"]}/auth"),
          headers: {"Authorization": token_header},
        );
        print("Response HTTP Code : ${response.body} | ${response.statusCode}");

        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        } else {
          return {"message": "User Session Berakhir"};
        }
      } else {
        return {"message": "Token tidak ditemukan"};
      }
    } catch (e) {
      print("get user data error : $e");
      return {"message": "Server error, Coba lagi nanti"};
    }
  }

  Future<Map> updateUser(
    String username,
    String email,
    String? password,
    String? phone_number,
  ) async {
    try {
      String? token = await _storage.read(key: 'jwt');
      if (token != null) {
        String token_header = "Bearer $token";
        print("Email : $email");
        Map<String, String> user_data = {};
        if (username != '') user_data['username'] = username;
        if (email != '') user_data['email'] = email;
        if (phone_number != '' && phone_number != null) user_data['phone_number'] = phone_number;
        if (password != '' && password != null) user_data['password'] = password;
        print("Phone Number : $phone_number");
        print("User Data : ${jsonEncode(user_data)}");
        Response response = await patch(
          Uri.parse("${dotenv.env["BACKEND_URL"]}/user"),
          headers: {"Content-Type": "application/x-www-form-urlencoded", "Authorization": token_header},
          body: jsonEncode(user_data),
        );
        print("Response Update : ${response.body}");
        if (response.statusCode == 201) {
          return jsonDecode(response.body);
        } else if (response.statusCode == 400) {
          return jsonDecode(response.body)["message"];
        } else {
          print(response.body);
          return {"message": "User Session Berakhir", "HTTP status code" : response.statusCode};
        }
      } else {
        return {"message": "Token Tidak ditemukan"};
      }
    } catch (e) {
      print("get user data error : $e");
      return {"message": "Server error, Coba lagi nanti"};
    }
  }
}
