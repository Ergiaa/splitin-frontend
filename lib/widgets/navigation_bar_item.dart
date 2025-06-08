import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';

// ignore: must_be_immutable
class NavigationItem extends StatelessWidget {
  NavigationItem(this.itemIndex, this.route, this.padding, this.icon);

  int itemIndex;
  String route;
  EdgeInsetsGeometry padding;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ProviderModel>(
      builder: (context, value, child) => Padding(
        padding: this.padding,
        child: IconButton(
          onPressed: () {
            final navigation_index = context.read<ProviderModel>();

            navigation_index.changeIndex(this.itemIndex);
            Navigator.pushNamed(context, this.route);
          },
          icon: Icon(this.icon),
          selectedIcon: Icon(this.icon, color: Colors.green),
          iconSize: 40,
          isSelected: value.selectedIndex == this.itemIndex ? true : false,
        ),
      ),
    );
  }
}
