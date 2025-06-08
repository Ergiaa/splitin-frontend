import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:splitin_frontend/constants/splitin_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final double screen_width = MediaQuery.sizeOf(context).width;
    final double screen_height = MediaQuery.sizeOf(context).height;
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text("Ini halaman login page", textAlign: TextAlign.center,),
      //   // leading: IconButton(onPressed: (){
      //   //   Navigator.pop(context);
      //   // }, icon: Icon(Icons.arrow_back)),
      //   automaticallyImplyLeading: false,
      // ),
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
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    
                  ),
                  
                ),
                labelText: "Email",
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          SizedBox(
            width: screen_width * 0.88,
            height: screen_height / 15,

            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    
                  ),
                  
                ),
                
                labelText: "Password",
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                
              ),
            ),
          ),
          Spacer(flex: 3),
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
                  backgroundColor: Color.fromARGB(255, 33, 150, 84),
                  iconSize: screen_width * screen_height / 12000,
                ),
              ),
            ),
          ),
          
          Spacer(flex: 8),
        ],
      ),
    );
  }
}
