import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final List<String> memberImages;
  final VoidCallback onTap;

  const GroupCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.memberImages,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Rectangle image for place
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Title and member avatars
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Overlapping member avatars
                    SizedBox(
                      height: 32,
                      child: Stack(
                        children: _buildMemberAvatars(),
                      ),
                    ),
                  ],
                ),
              ),

              // Right arrow button
              IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMemberAvatars() {
    List<Widget> avatars = [];

    for (int i = 0; i < memberImages.length && i < 4; i++) {
      avatars.add(
        Positioned(
          left: i * 20.0, // Overlap by 20 pixels
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(memberImages[i]),
            ),
          ),
        ),
      );
    }

    // Add "+X more" indicator if there are more than 4 members
    if (memberImages.length > 4) {
      avatars.add(
        Positioned(
          left: 4 * 20.0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              color: Colors.grey[300],
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              child: Text(
                '+${memberImages.length - 4}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return avatars;
  }
}