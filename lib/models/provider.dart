
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:splitin_frontend/controllers/auth_controller.dart';
import 'package:splitin_frontend/services/auth_service.dart';

class ProviderModel extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isLoadingLogin = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _authController = AuthController();

  int get selectedIndex => _selectedIndex;
  bool get isLoadingLogin => _isLoadingLogin;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordConfirmationController =>
      _passwordConfirmationController;
  AuthController get authController => _authController;

  void changeIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  void changeLoadingLogin() {
    _isLoadingLogin = !_isLoadingLogin;
    notifyListeners();
  }
}
