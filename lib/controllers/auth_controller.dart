import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService(FlutterSecureStorage());

  Future<String?> login(String email, String password) async {
    final token = await _authService.login(email, password);
    return token;
  }

  Future<String?> get getToken => _authService.getToken;
  Future<void> deleteToken() async {
    _authService.deleteToken();
  }

  Future<int?> signup(String username, String email, String password) => _authService.signup(username, email, password);
  Future<Map> get getUserSession => _authService.getUserSession();
  Future<Map> updateUser(String username, String email, String? phone_number, String? student_id) => _authService.updateUser(username, email, phone_number, student_id);
  Future<Map> get createBill => _authService.createBill();
  Future<Map> addItemsToBill(String billId, List<Map> items) => _authService.addItemsToBill(billId, items);
  Future<Map> get getAllUser => _authService.getAllUser();
}
