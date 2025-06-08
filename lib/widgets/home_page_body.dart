import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';



class HomePageBody extends Consumer<ProviderModel>{
  static List<StatelessWidget> pages = <StatelessWidget>[
    Container(color: const Color.fromARGB(255, 255, 165, 165),),
    Container(color: const Color.fromARGB(255, 155, 207, 249),),
    Container(color: const Color.fromARGB(255, 252, 230, 165),),
    Container(color: const Color.fromARGB(255, 183, 244, 185),)
  ];
  HomePageBody() : super(builder: (context, value, child) => pages[value.selectedIndex],); 
}