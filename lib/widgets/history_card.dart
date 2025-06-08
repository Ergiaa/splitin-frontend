import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final String totalAmount;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String statusText;
  final Color statusBackgroundColor;
  final Color statusTextColor;

  const HistoryCard({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.totalAmount,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.statusText,
    required this.statusBackgroundColor,
    required this.statusTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBackgroundColor.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 15),
          Expanded( // Allows title and date to take available space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                totalAmount,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: statusBackgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(color: statusTextColor, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}