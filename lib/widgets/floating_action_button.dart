import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';

class SplitinFloatingActionButton extends Consumer<ProviderModel> {
  SplitinFloatingActionButton()
      : super(
    builder: (context, value, child) => FloatingActionButton(
      heroTag: 'splitin-fab',
      onPressed: () {
        Navigator.pushNamed(context, "/bill-item");
      },
      shape: CircleBorder(),
      elevation: 12,
      backgroundColor: const Color.fromARGB(255, 249, 181, 204),
      child: ImageIcon(
        AssetImage("assets/images/star.png"),
        size: 50,
        color: const Color.fromARGB(255, 242, 114, 2),
      ),
    ),
  );
}

