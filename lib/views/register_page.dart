import 'package:flutter/material.dart';
import 'package:splitin_frontend/constants/splitin_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final double screen_width = MediaQuery.sizeOf(context).width;
    final double screen_height = MediaQuery.sizeOf(context).height;
    // TODO: implement build
    return Scaffold(
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
                      image: AssetImage("assets/images/buataccountdetail.png"),
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
                      obscureText: true,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),

                        labelText: "Username",
                        filled: true,
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
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

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),

                        labelText: "Email",
                        filled: true,
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
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

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),

                        labelText: "Password",
                        filled: true,
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
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

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),

                        labelText: "Ulangi Password",
                        filled: true,
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 2),
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 8),
                  child: SizedBox(
                    width: screen_width * 0.78,
                    height: screen_height / 17,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, "/home");
                      },
                      label: Text(
                        "Masuk",
                        style: TextStyle(
                          fontSize: screen_height * screen_width / 18289,
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
    );
  }
}
