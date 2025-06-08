import 'package:flutter/material.dart';
class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, "/login");
            }, child: Text("button login pake email")),
            ElevatedButton(onPressed: (){}, child: Text("login oauth google (masih belum sih)")),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, "/register");
            }, child: Text("Register akun"))

          ],
        ),
      )
    );
  }
}