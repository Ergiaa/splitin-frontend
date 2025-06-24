import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/constants/splitin_colors.dart';
import 'package:splitin_frontend/models/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();

    // Wait until widget is built, then show loader
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _showLoadingDialog();

      String? token = await _loadUserSession(); // Your async init logic

      if (token == null) {
        Navigator.of(context, rootNavigator: true).pop();
      } else {
        print("User Session Token ${token}");
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  Future<String?> _loadUserSession() async {
    return context.read<ProviderModel>().authController.getToken;
    // await Future.delayed(Duration(seconds: 2)); // Simulate API/data fetch
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        // The background color of the dialog
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // The loading indicator
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              // The text
              const Text("Loading...", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screen_width = MediaQuery.sizeOf(context).width;
    final double screen_height = MediaQuery.sizeOf(context).height;
    // TODO: implement build
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          SystemNavigator.pop();
        }
      },
      child: Consumer<ProviderModel>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: SplitinColors.main_page_background_color,
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
                    Image(image: AssetImage("assets/images/eye.png")),
                    Positioned(
                      bottom: 90,
                      top: 1,
                      child: Image(
                        image: AssetImage("assets/images/lightning.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: screen_width * 0.85,
                height: screen_height / 15,
                child: FilledButton.icon(
                  onPressed: () {
                    value.setLoginErrorMessage(null);
                    Navigator.pushNamed(context, "/login");
                  },
                  label: Text(
                    "Masuk dengan email",
                    style: TextStyle(fontSize: 20, fontFamily: "montserrat"),
                  ),
                  icon: ImageIcon(
                    AssetImage("assets/images/round-email.png"),
                    color: Color.fromARGB(255, 33, 150, 84),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color.fromARGB(255, 33, 150, 84),
                    iconSize: screen_width * screen_height / 12000,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(top: 8),
                child: SizedBox(
                  width: screen_width * 0.85,
                  height: screen_height / 15,
                  child: FilledButton.icon(
                    onPressed: () {},
                    label: Text(
                      "Masuk dengan Google",
                      style: TextStyle(
                        fontSize: screen_height * screen_width / 18289,
                        fontFamily: "montserrat",
                      ),
                    ),
                    icon: ImageIcon(AssetImage("assets/images/google.png")),
                    style: FilledButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 33, 150, 84),
                      iconSize: screen_width * screen_height / 12000,
                    ),
                  ),
                ),
              ),
              Spacer(flex: 9),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Belum punya akun? ",
                        style: TextStyle(
                          fontSize: screen_height * screen_width / 18289 - 3,
                          color: Color.fromARGB(255, 33, 150, 84),
                          fontFamily: "montserrat",
                        ),
                      ),
                      TextSpan(
                        text: "Daftar",
                        style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 1, 94, 41),
                          fontFamily: "montserrat",
                          fontWeight: FontWeight.w700,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            value.setRegisterErrorMessage(null);
                            Navigator.pushNamed(context, "/register");
                          },
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
