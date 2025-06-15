
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier{
  final AuthService _authService = AuthService(
      FlutterSecureStorage(),
    );


  Future<String?> login(String email, String password) async {
    final token = await _authService.login(email, password);
    return token;
  }

  // Future<String?> signup(User user, String password) async {
  //   final token = await _authService.signup(
  //     user.fullName,
  //     user.email,
  //     user.phoneNumber,
  //     password,
  //   );
  //   // Additional business logic goes here
  //   return token;
  // }
}
