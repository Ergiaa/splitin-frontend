import 'dart:convert';
import 'dart:developer';
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
    String? phone_number,
    String? student_id,
  ) async {
    try {
      String? token = await _storage.read(key: 'jwt');
      if (token != null) {
        String token_header = "Bearer $token";
        print("Email : $email");
        Map<String, String> userData = {};
        if (username != '') userData['username'] = username;
        if (email != '') userData['email'] = email;
        if (phone_number != null) userData['phone_number'] = phone_number;
        if (student_id != null) userData['student_id'] = student_id;
        print("${username} || ${email} || ${phone_number} || ${student_id}");
        print("USER DATA : ${userData}");
        Response response = await patch(
          Uri.parse("${dotenv.env["BACKEND_URL"]}/user"),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": token_header,
          },
          body: userData,
        );

        print("Response Update : ${response.body}");
        if (response.statusCode == 201) {
          return jsonDecode(response.body);
        } else if (response.statusCode == 400) {
          return jsonDecode(response.body);
        } else {
          print(response.body);
          return {
            "message": "User Session Berakhir",
            "HTTP status code": response.statusCode,
          };
        }
      } else {
        return {"message": "Token Tidak ditemukan"};
      }
    } catch (e) {
      print("get user data error : $e");
      return {"message": "Server error, Coba lagi nanti"};
    }
  }

  Future<Map> createBill() async {
    try {
      String? token = await _storage.read(key: 'jwt');
      if (token != null) {
        String token_header = "Bearer $token";
        Response response = await post(
          Uri.parse("${dotenv.env["BACKEND_URL"]}/bills"),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": token_header,
          },
          body: {},
        );
        log(response.body);
        if (response.statusCode == 201) {
          return jsonDecode(response.body);
        } else {
          return {
            "message": "User Session Berakhir",
            "HTTP status code": response.statusCode,
          };
        }
      } else {
        return {"message": "Token Tidak ditemukan"};
      }
    } catch (e) {
      return {"message": "Server error, Coba lagi nanti"};
    }
  }

  Future<Map> addItemsToBill(String billId, List<Map> items) async {
    try {
      String? token = await _storage.read(key: 'jwt');
      if (token != null) {
        String token_header = "Bearer $token";
        Response response = await post(
          Uri.parse("${dotenv.env["BACKEND_URL"]}/bills/${billId}/items"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": token_header,
          },
          body: jsonEncode(items)
        );
        log(response.body);
        if (response.statusCode == 201) {
          return jsonDecode(response.body);
        } else if (response.statusCode == 403){
          return {
            "message":"Item telah dibuat",
            "statusCode" : response.statusCode
          };
        } else{
          return {
            "message": "User Session Berakhir",
            "statusCode": response.statusCode,
          };
        }
      } else {
        return {"message": "Token Tidak ditemukan"};
      }
    } catch (e) {
      return {"message": "Server error, Coba lagi nanti"};
    }
  }

  Future<Map> getAllUser() async{
    try{
      Map currUser = await getUserSession();
      if (currUser["data"] != null){
        Response response = await get(Uri.parse("${dotenv.env["BACKEND_URL"]}/user?username"));
        log(response.body);
        if (response.statusCode == 201){
          return jsonDecode(response.body);
        }else{
          return {"message":"Server Error"};
        }
      }else{
        return {"message": "Token Tidak ditemukan"};
      }
    } catch (e){
      return {"message":e};
    }
  }


}
