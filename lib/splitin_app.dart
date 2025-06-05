import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/navigation_index_model.dart';
import 'package:splitin_frontend/splitin_body.dart';
import 'package:splitin_frontend/splitin_bottom_navigation_bar.dart';
import 'package:splitin_frontend/splitin_floating_action_button.dart';

class SplitInApp extends StatefulWidget {
  const SplitInApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplitInState();
}

class _SplitInState extends State<SplitInApp> {
  static List<AppBar> appBars = <AppBar>[
    AppBar(
      title: Text("Home", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      backgroundColor: const Color.fromARGB(255, 255, 165, 165),
    ),
    AppBar(
      title: Text("Groups", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      backgroundColor: const Color.fromARGB(255, 155, 207, 249),
    ),
    AppBar(
      title: Text("History", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      backgroundColor: const Color.fromARGB(255, 252, 230, 165),
    ),
    AppBar(
      title: Text("Contacts", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      backgroundColor: const Color.fromARGB(255, 183, 244, 185),
    )
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<NavigationIndexModel>(
      builder: (context, value, child) => Scaffold(
        appBar: appBars[value.selectedIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FittedBox(
            fit: BoxFit.fill,
            child: SplitinFloatingActionButton(),
          ),
        ),
        body: SplitinBodyPage(),
        bottomNavigationBar: SplitInNavBar(),
      ),
    );
  }
}
