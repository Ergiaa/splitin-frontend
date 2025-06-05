import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/login_page.dart';
import 'package:splitin_frontend/main_page.dart';
import 'package:splitin_frontend/navigation_index_model.dart';
import 'package:splitin_frontend/register_page.dart';
import 'package:splitin_frontend/scan_page.dart';
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
      home: const MainPage(),
      routes: {
        // "/": (context) => const MainPage(),
        "/scanpage": (context) => const ScanPage(),
        "/homepage":(context) => const SplitInApp(),
        "/loginpage": (context) => const LoginPage(),
        "/registerpage": (context) => const RegisterPage()        
      },
    );
  }
}

