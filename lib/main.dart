import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/views/login_page.dart';
import 'package:splitin_frontend/views/main_page.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/views/register_page.dart';
import 'package:splitin_frontend/views/add_bills_page.dart';
import 'package:splitin_frontend/views/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProviderModel(),
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
        "/homepage":(context) => const HomePage(),
        "/loginpage": (context) => const LoginPage(),
        "/registerpage": (context) => const RegisterPage()
      },
    );
  }
}

