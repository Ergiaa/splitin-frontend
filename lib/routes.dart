import 'package:flutter/material.dart';
import 'package:splitin_frontend/views/bill_items_page.dart';
import 'package:splitin_frontend/views/group_page.dart';
import 'package:splitin_frontend/views/history_page.dart';
import 'package:splitin_frontend/views/home_page.dart';
import 'package:splitin_frontend/views/login_page.dart';
import 'package:splitin_frontend/views/main_page.dart';
import 'package:splitin_frontend/views/profile_page.dart';
import 'package:splitin_frontend/views/register_page.dart';

class SplitInRoute{
  static const String main = "/";
  static const String register = "/register";
  static const String login = "/login";
  static const String home = "/home";
  static const String groups = "/groups";
  static const String history = "/history";
  static const String profile = "/profile";

  // Bill session
  static const String bill_item = "/bill-item";
  static const String scan = "/bill-item/scan";
  static const String add_participant = "/bill-item/add-participants";


  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case groups:
        return MaterialPageRoute(builder: (_) => GroupPage());
      case history:
        return MaterialPageRoute(builder: (_) => HistoryPage());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case bill_item:
        return MaterialPageRoute(builder: (_) => BillItemsPage());
      default:
        return MaterialPageRoute(builder: (_) => MainPage());
    };
  } 

}