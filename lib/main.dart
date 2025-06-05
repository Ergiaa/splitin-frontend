import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/navigation_index_model.dart';
import 'package:splitin_frontend/splitin_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationIndexModel(),
      child: MainApp(),
      
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplitInApp(),
      routes: {
        "/scanpage": (context) => const ScanPage(),
        "/mainpage":(context) => const SplitInApp()
      },
    );
  }
}

class ScanPage extends StatefulWidget{
  const ScanPage({super.key});

  @override
  State<StatefulWidget> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
      ),
    );
  }
}
