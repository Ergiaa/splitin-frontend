import 'package:flutter/material.dart';
import 'package:splitin_frontend/models/bill_data.dart';

class TagihanHomeCard extends StatelessWidget {
  final String title;
  final String date;
  final String totalAmount;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final List<BillParticipant> participants;

  const TagihanHomeCard({
    Key? key,
    required this.title,
    required this.date,
    required this.totalAmount,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.participants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: iconBackgroundColor,
                  radius: 20,
                  child: Icon(icon, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  totalAmount,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Divider(height: 25),

            // Avatar stack + tag list
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvatars(participants),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: participants.map(_buildTag).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatars(List<BillParticipant> participants) {
    return SizedBox(
      height: 32,
      width: 32.0 + (participants.length - 1) * 20.0,
      child: Stack(
        children: participants.asMap().entries.map((entry) {
          final index = entry.key;
          final participant = entry.value;
          return Positioned(
            left: index * 20.0,
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(participant.imageUrl),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTag(BillParticipant p) {
    String label = p.transactionType == BillTransactionType.owesYou
        ? 'Utang ke kamu'
        : 'Kamu utang';

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: p.tagBackgroundColor,
        borderRadius: BorderRadius.circular(40), // pill shape
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            p.amount,
            style: TextStyle(
              color: p.tagTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
