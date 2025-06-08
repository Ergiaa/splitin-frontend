import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/widgets/bottom_navigation_bar.dart';
import 'package:splitin_frontend/widgets/floating_action_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ProviderModel>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Groups",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 183, 244, 185),
          automaticallyImplyLeading: false,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FittedBox(
            fit: BoxFit.fill,
            child: SplitinFloatingActionButton(),
          ),
        ), // edit ini
        body: Container(
          color: const Color.fromARGB(255, 183, 244, 185),
        ), // edit ini
        bottomNavigationBar: SplitInNavBar(),
      ),
    );
  }
}
