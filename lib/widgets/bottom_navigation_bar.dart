import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';



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
              Padding(
                padding: EdgeInsetsGeometry.only(right: 30),
                child: IconButton(
                  onPressed: () {
                    final navigation_index = context.read<ProviderModel>();

                    navigation_index.changeIndex(0);        
                  },
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(Icons.home, color: Colors.green,),
                  iconSize: 40,
                  isSelected: value.selectedIndex == 0 ? true : false,
                )),
              Padding(
                padding: EdgeInsetsGeometry.only(right: 35),
                child: IconButton(
                  onPressed: () {
                    final navigation_index = context.read<ProviderModel>();

                    navigation_index.changeIndex(1);  
                  },
                  icon: Icon(Icons.group),
                  selectedIcon: Icon(Icons.group, color: Colors.green,),
                  iconSize: 40,
                  isSelected: value.selectedIndex == 1 ? true : false,
                )),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 35),
                child: IconButton(
                  onPressed: () {
                    final navigation_index = context.read<ProviderModel>();

                    navigation_index.changeIndex(2);  
                  },
                  icon: Icon(Icons.history),
                  selectedIcon: Icon(Icons.history, color: Colors.green,),
                  iconSize: 40,
                  isSelected: value.selectedIndex == 2 ? true : false,
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 30),
                child: IconButton(
                  onPressed: () {
                    final navigation_index = context.read<ProviderModel>();

                    navigation_index.changeIndex(3);  
                  },
                  icon: Icon(Icons.person,),
                  selectedIcon: Icon(Icons.person, color: Colors.green,),
                  iconSize: 40,
                  isSelected: value.selectedIndex == 3 ? true : false,
                ),
              ),
            ],
          ),
        )
        ),
      );
}
