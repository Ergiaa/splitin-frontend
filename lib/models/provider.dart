import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:splitin_frontend/controllers/auth_controller.dart';
import 'package:splitin_frontend/models/participant.dart';
import 'package:splitin_frontend/services/auth_service.dart';
// import 'package:splitin_frontend/widgets/_text_editing_controller.dart';

class ProviderModel extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isLoadingLogin = false;
  bool _isLoadingRegister = false;
  bool _profileEditState = false;
  bool _profileInitProcess = false;
  String? _loginErrorMessage;
  String? _registerErrorMessage;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();
  final _authController = AuthController();
  final List<Participant> _allParticipants = [];

  bool checkEmailValidation() {
    return _emailController.text.contains("@") &&
        _emailController.text.split("@").length > 1 &&
        _emailController.text.split("@")[1].contains(".");
  }

  List<Participant> get allParticipants => _allParticipants;
  bool get profileEditState => _profileEditState;
  bool get profileInitProcess => _profileInitProcess;
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
  TextEditingController get studentIDController => _studentIDController;
  AuthController get authController => _authController;

  void fillAllParticipants(Map allUser, String sessionId) {
    for (Map user in allUser["data"]) {
      if (user["id"] != sessionId) {
        print("user ${user}");
        _allParticipants.add(
          Participant(
            id: user["id"],
            name: user["username"],
            email: user["email"],
            isSelected: false,
          ),
        );
      }
    }
  }

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

  void changeProfileEditState() {
    _profileEditState = !_profileEditState;
    notifyListeners();
  }

  void changeProfileInitState() {
    _profileInitProcess = !_profileInitProcess;
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
    _studentIDController.clear();
  }
}
