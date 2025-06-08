import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/widgets/home_page_body.dart';
import 'package:splitin_frontend/widgets/bottom_navigation_bar.dart';
import 'package:splitin_frontend/widgets/floating_action_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Consumer<ProviderModel>(
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
        body: HomePageBody(),
        bottomNavigationBar: SplitInNavBar(),
      ),
    );
  }
}
