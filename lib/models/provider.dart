import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:splitin_frontend/controllers/auth_controller.dart';
import 'package:splitin_frontend/services/auth_service.dart';
// import 'package:splitin_frontend/widgets/_text_editing_controller.dart';

class ProviderModel extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isLoadingLogin = false;
  bool _isLoadingRegister = false;
  String? _loginErrorMessage;
  String? _registerErrorMessage;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _authController = AuthController();

  int get selectedIndex => _selectedIndex;
  bool get isLoadingLogin => _isLoadingLogin;
  bool get isLoadingRegister => _isLoadingRegister;
  String? get loginErrorMessage => _loginErrorMessage;
  String? get registerErrorMessage => _registerErrorMessage;
  bool get emptyLoginForm =>
      _emailController.text == '' || _passwordController.text == '';
  bool get emptyRegisterForm =>
      _emailController.text == '' ||
      _passwordController.text == '' ||
      _usernameController.text == '' ||
      _passwordConfirmationController.text == '';
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordConfirmationController =>
      _passwordConfirmationController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  AuthController get authController => _authController;

  void changeIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  void changeLoadingLogin() {
    _isLoadingLogin = !_isLoadingLogin;
    notifyListeners();
  }

  void changeLoadingRegister() {
    _isLoadingRegister = !_isLoadingRegister;
    notifyListeners();
  }

  void setLoginErrorMessage(String? message) {
    _loginErrorMessage = message;
  }

  void setRegisterErrorMessage(String? message) {
    _registerErrorMessage = message;
  }

  void clearAllForm() {
    _emailController.clear();
    _passwordController.clear();
    _passwordConfirmationController.clear();
    _usernameController.clear();
    _phoneNumberController.clear();
  }
}
