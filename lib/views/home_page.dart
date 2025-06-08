import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/widgets/bottom_navigation_bar.dart';
import 'package:splitin_frontend/widgets/floating_action_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ProviderModel>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 165, 165),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FittedBox(
            fit: BoxFit.fill,
            child: SplitinFloatingActionButton(),
          ),
        ),
        body: Container(color: const Color.fromARGB(255, 255, 165, 165)),
        bottomNavigationBar: SplitInNavBar(),
      ),
    );
  }
}
