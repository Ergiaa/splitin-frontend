import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/widgets/navigation_bar_item.dart';



class SplitInNavBar extends Consumer<ProviderModel> {
  SplitInNavBar()
    : super(
        builder: (context, value, child) => BottomAppBar(
          shape: CircularNotchedRectangle(),
      elevation: 0,
        child: SizedBox(
          height: 18,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            // spacing: 30,
            children: <Widget>[
              NavigationItem(0, "/home", EdgeInsetsGeometry.only(right: 30), Icons.home),
              NavigationItem(1, "/groups", EdgeInsetsGeometry.only(right: 35), Icons.group),
              NavigationItem(2, "/history", EdgeInsetsGeometry.only(left: 35), Icons.history),
              NavigationItem(3, "/profile", EdgeInsetsGeometry.only(left: 35), Icons.person),
            ],
          ),
        )
        ),
      );
}
