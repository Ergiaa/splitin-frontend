import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/widgets/bottom_navigation_bar.dart';
import 'package:splitin_frontend/widgets/floating_action_button.dart';

class BillItemsPage extends StatefulWidget {
  const BillItemsPage({super.key});

  @override
  State<StatefulWidget> createState() => _BillItemsPageState();
}

class _BillItemsPageState extends State<BillItemsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ProviderModel>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Tambahkan Item",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon:Icon(Icons.arrow_back)),
        ),
        body: Container(
          color: Colors.white,

        ), // edit ini
      ),
    );
  }
}
