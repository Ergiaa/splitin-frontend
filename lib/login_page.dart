import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Ini halaman login page", textAlign: TextAlign.center,),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Container(
            child: Column(
              children: [
                Spacer(),
                Text("Ini Login page"),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/homepage");
                }, child: Text("Anggep aja udah authenticated")),
                Spacer()
                
              ],
            ),

        ),
      ),
      
    );
  }
}