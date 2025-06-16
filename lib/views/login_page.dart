import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/constants/splitin_colors.dart';
import 'package:splitin_frontend/controllers/auth_controller.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? _isShowError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isShowError = false;
  }

  @override
  Widget build(BuildContext context) {
    final double screen_width = MediaQuery.sizeOf(context).width;
    final double screen_height = MediaQuery.sizeOf(context).height;
    // TODO: implement build
    return Consumer<ProviderModel>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: SplitinColors.login_page_background_color,
        body: Column(
          children: [
            Spacer(flex: 3),
            Padding(
              padding: EdgeInsetsGeometry.only(left: screen_width / 22),

              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(image: AssetImage("assets/images/splitin.png")),
                    Image(
                      image: AssetImage("assets/images/bagiratagakribet.png"),
                    ),
                  ],
                ),
              ),
            ),

            Spacer(flex: 7),
            Container(
              alignment: Alignment.bottomCenter,
              height: 250,
              width: double.infinity,
              // color: Colors.blue,
              child: Stack(
                alignment: AlignmentDirectional.center,
                fit: StackFit.expand,
                children: [
                  Image(image: AssetImage("assets/images/eye2.png")),
                  Positioned(
                    bottom: 90,
                    top: 1,
                    child: Image(
                      image: AssetImage("assets/images/soft-star.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screen_width * 0.88,
              height: screen_height / 15,

              child: TextField(
                controller: value.emailController,
                onTapOutside: (PointerDownEvent event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    borderSide: _isShowError!
                        ? (value.emailController.text == ''
                              ? BorderSide(color: Colors.red, width: 1)
                              : BorderSide())
                        : BorderSide(),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    borderSide: _isShowError!
                        ? (value.emailController.text == ''
                              ? BorderSide(color: Colors.red, width: 3)
                              : BorderSide())
                        : BorderSide(),
                  ),
                  labelText: "Email",
                  labelStyle: _isShowError!
                      ? (value.emailController.text == ''
                            ? TextStyle(color: Colors.red)
                            : null)
                      : null,

                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),

            SizedBox(
              width: screen_width * 0.88,
              height: screen_height / 15,

              child: TextField(
                controller: value.passwordController,
                onTapOutside: (PointerDownEvent event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    borderSide: _isShowError!
                        ? (value.passwordController.text == ''
                              ? BorderSide(color: Colors.red, width: 1)
                              : BorderSide())
                        : BorderSide(),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    borderSide: _isShowError!
                        ? (value.passwordController.text == ''
                              ? BorderSide(color: Colors.red, width: 3)
                              : BorderSide())
                        : BorderSide(),
                  ),

                  labelText: "Password",

                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: _isShowError!
                      ? (value.passwordController.text == ''
                            ? TextStyle(color: Colors.red)
                            : null)
                      : null,
                ),
              ),
            ),
            Spacer(flex: 1),
            Center(
              child: value.loginErrorMessage == null
                  ? null
                  : Text(
                      value.loginErrorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
            ),
            Spacer(flex: 2),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 8),
              child: SizedBox(
                width: screen_width * 0.78,
                height: screen_height / 17,
                child: FilledButton.icon(
                  onPressed: () async {
                    value.changeLoadingLogin();
                    _isShowError = true;
                    if (!value.emptyLoginForm) {
                      String? token = await value.authController.login(
                        value.emailController.text,
                        value.passwordController.text,
                      );
                      print("Email = ${value.emailController.text}");
                      print("Password = ${value.passwordController.text}");
                      print("Login Token = ${token}");
                      if (token != null) {
                        Navigator.pushReplacementNamed(context, "/home");
                        value.clearAllForm();
                      } else {
                        _isShowError = false;
                        value.setLoginErrorMessage("Invalid Email or Password");
                      }
                    } else {
                      value.setLoginErrorMessage(
                        "Email or Password can't be empty",
                      );
                    }
                    
                    value.changeLoadingLogin();
                  },
                  label: value.isLoadingLogin
                      ? CircularProgressIndicator(
                          color: SplitinColors.backgroundColor,
                          backgroundColor: SplitinColors.green_button,
                        )
                      : Text(
                          "Masuk",
                          style: TextStyle(
                            fontSize: screen_height * screen_width / 18289,
                            fontFamily: "montserrat",
                          ),
                        ),
                  style: FilledButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: SplitinColors.green_button,
                    iconSize: screen_width * screen_height / 12000,
                  ),
                ),
              ),
            ),

            Spacer(flex: 8),
          ],
        ),
      ),
    );
  }
}
