import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/constants/splitin_colors.dart';
import 'package:splitin_frontend/models/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        resizeToAvoidBottomInset: false,
        backgroundColor: SplitinColors.register_page_background_color,
        body: Column(
          children: [
            Spacer(flex: 2),
            Padding(
              padding: EdgeInsetsGeometry.only(left: screen_width / 22),

              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(image: AssetImage("assets/images/buat-account.png")),
                    Padding(
                      padding: EdgeInsetsGeometry.only(top: 10),
                      child: Image(
                        image: AssetImage(
                          "assets/images/buataccountdetail.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(flex: 2),
            Container(
              // color: Colors.white,
              width: screen_width * 0.95,
              height: screen_height * 0.75,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 231, 229, 229),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(40, 50),
                  topRight: Radius.elliptical(40, 50),
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Spacer(flex: 2),
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 12),
                    child: SizedBox(
                      width: screen_width * 0.88,
                      height: screen_height / 15,

                      child: TextField(
                        controller: value.usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: _isShowError!
                                ? (value.usernameController.text == ''
                                      ? BorderSide(color: Colors.red, width: 1)
                                      : BorderSide.none)
                                : BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: _isShowError!
                                ? (value.usernameController.text == ''
                                      ? BorderSide(color: Colors.red, width: 2)
                                      : BorderSide.none)
                                : BorderSide.none,
                          ),
                          labelText: "Username",
                          filled: true,
                          labelStyle: _isShowError!
                              ? (value.usernameController.text == ''
                                    ? TextStyle(color: Colors.red)
                                    : null)
                              : null,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 12),
                    child: SizedBox(
                      width: screen_width * 0.88,
                      height: screen_height / 15,

                      child: TextField(
                        controller: value.emailController,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: _isShowError!
                                ? (value.emailController.text == ''
                                      ? BorderSide(color: Colors.red, width: 1)
                                      : BorderSide.none)
                                : BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: _isShowError!
                                ? (value.emailController.text == ''
                                      ? BorderSide(color: Colors.red, width: 1)
                                      : BorderSide.none)
                                : BorderSide.none,
                          ),
                          labelText: "Email",
                          filled: true,
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: _isShowError!
                              ? (value.emailController.text == ''
                                    ? TextStyle(color: Colors.red)
                                    : null)
                              : null,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 12),
                    child: SizedBox(
                      width: screen_width * 0.88,
                      height: screen_height / 15,

                      child: TextField(
                        obscureText: true,
                        controller: value.passwordController,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: _isShowError!
                                ? (value.passwordController.text == ''
                                      ? BorderSide(color: Colors.red, width: 1)
                                      : BorderSide.none)
                                : BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: _isShowError!
                                ? (value.passwordController.text == ''
                                      ? BorderSide(color: Colors.red, width: 1)
                                      : BorderSide.none)
                                : BorderSide.none,
                          ),
                          labelText: "Password",
                          filled: true,
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: _isShowError!
                              ? (value.passwordController.text == '' ||
                                        value
                                                .passwordConfirmationController
                                                .text !=
                                            value.passwordController.text
                                    ? TextStyle(color: Colors.red)
                                    : null)
                              : null,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 12),
                    child: SizedBox(
                      width: screen_width * 0.88,
                      height: screen_height / 15,

                      child: TextField(
                        obscureText: true,
                        controller: value.passwordConfirmationController,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: _isShowError!
                                ? (value.passwordConfirmationController.text ==
                                          ''
                                      ? BorderSide(color: Colors.red, width: 1)
                                      : BorderSide.none)
                                : BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: _isShowError!
                                ? (value.passwordConfirmationController.text ==
                                          ''
                                      ? BorderSide(color: Colors.red, width: 1)
                                      : BorderSide.none)
                                : BorderSide.none,
                          ),

                          labelText: "Ulangi Password",
                          filled: true,
                          labelStyle: _isShowError!
                              ? (value.passwordConfirmationController.text ==
                                            '' ||
                                        value
                                                .passwordConfirmationController
                                                .text !=
                                            value.passwordController.text
                                    ? TextStyle(color: Colors.red)
                                    : null)
                              : null,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                  Center(
                    child: value.registerErrorMessage == null
                        ? null
                        : Text(
                            value.registerErrorMessage!,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red),
                          ),
                  ),
                  Spacer(flex: 2),
                  Padding(
                    padding: EdgeInsetsGeometry.only(),
                    child: SizedBox(
                      width: screen_width * 0.78,
                      height: screen_height / 17,
                      child: FilledButton.icon(
                        onPressed: () async {
                          value.changeLoadingRegister();
                          if (!_isShowError!) {
                            _isShowError = true;
                          }
                          if (!value.emptyRegisterForm) {
                            if (value.passwordController.text ==
                                value.passwordConfirmationController.text) {
                              int? statusResponse = await value.authController
                                  .signup(
                                    value.usernameController.text,
                                    value.emailController.text,
                                    value.passwordController.text,
                                  );
                              if (statusResponse == 201) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 8),
                                        Text("Register Successful"),
                                      ],
                                    ),
                                    content: Text(
                                      "User has successfully created.",
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(context, "/");
                                          value.clearAllForm();
                                        },
                                        child: Text(
                                          "OK",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                
                              } else if (statusResponse == 400){
                                value.setRegisterErrorMessage(
                                  "User sudah ada",
                                );
                              } else{
                                value.setRegisterErrorMessage("Terjadi Kesalahan saat registrasi");
                              }
                            } else {
                              value.setRegisterErrorMessage(
                                "Password tidak sama",
                              );
                            }
                          }

                          value.changeLoadingRegister();
                        },
                        label: value.isLoadingRegister
                            ? CircularProgressIndicator(
                                color: SplitinColors.backgroundColor,
                                backgroundColor:
                                    SplitinColors.orange_star_color,
                              )
                            : Text(
                                "Daftar",
                                style: TextStyle(
                                  fontSize:
                                      screen_height * screen_width / 18289,
                                  fontFamily: "montserrat",
                                ),
                              ),
                        style: FilledButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: SplitinColors.orange_star_color,
                          iconSize: screen_width * screen_height / 12000,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
