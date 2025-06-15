import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/routes.dart';
import 'package:splitin_frontend/views/main_page.dart';
import 'package:splitin_frontend/models/provider.dart';

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
      initialRoute: SplitInRoute.main,
      onGenerateRoute: SplitInRoute.generateRoute,
    );
  }
}
