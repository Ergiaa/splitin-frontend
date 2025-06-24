import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splitin_frontend/models/item.dart';
class CartListItem extends StatelessWidget {
  const CartListItem({super.key, required this.item, required this.formatter});

  final Item item;
  final NumberFormat formatter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Kolom untuk Nama Item dan Harga Satuan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatter.format(item.price),
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Spacer agar ada jarak
          const SizedBox(width: 16),

          Row(
            children: [
              Text(
                '${item.quantity}X',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 100,
                child: Text(
                  formatter.format(item.totalPrice),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}