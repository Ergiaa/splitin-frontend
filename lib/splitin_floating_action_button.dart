import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/navigation_index_model.dart';

class SplitinFloatingActionButton extends Consumer<NavigationIndexModel> {
  SplitinFloatingActionButton()
    : super(builder: (context, value, child) => FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/scanpage");
        },
        shape: CircleBorder(),
        elevation: 12,
        backgroundColor: const Color.fromARGB(255, 249, 181, 204),
        child: ImageIcon(AssetImage("assets/images/star.png"), size: 50, color: const Color.fromARGB(255, 242, 114, 2),)
      
    ),);
}
