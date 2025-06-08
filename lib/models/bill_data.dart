import 'package:flutter/material.dart';

enum BillTransactionType {
  youOwe,
  owesYou,
}

class BillParticipant {
  final String imageUrl;
  final BillTransactionType transactionType;
  final String amount;
  final Color tagBackgroundColor;
  final Color tagTextColor;

  BillParticipant({
    required this.imageUrl,
    required this.transactionType,
    required this.amount,
    required this.tagBackgroundColor,
    required this.tagTextColor,
  });
}