import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/widgets/bottom_navigation_bar.dart';
import 'package:splitin_frontend/widgets/floating_action_button.dart';
import 'package:splitin_frontend/widgets/group_card.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final List<Map<String, dynamic>> groupData = [
    {
      'title': 'Trip to Bali',
      'image': 'assets/images/person.jpeg',
      'members': [
        'assets/images/person.jpeg',
        'assets/images/person.jpeg',
        'assets/images/person.jpeg'
      ]
    },
    {
      'title': 'Office Lunch',
      'image': 'assets/images/person.jpeg',
      'members': [
        'assets/images/person.jpeg',
        'assets/images/person.jpeg'
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderModel>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: const Text(
                "Groups",
                style: TextStyle(
                  color: Color(0xFF388E3C),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 70,
          width: 70,
          child: FittedBox(
            fit: BoxFit.fill,
            child: SplitinFloatingActionButton(),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: ListView.builder(
                itemCount: groupData.length,
                itemBuilder: (context, index) {
                  final group = groupData[index];
                  return GroupCard(
                    title: group['title'],
                    imageUrl: group['image'],
                    memberImages: List<String>.from(group['members']),
                    onTap: () {
                      // Implement navigation to group detail
                    },
                  );
                },
              ),
            ),
            Positioned(
              bottom: 30,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  // Add new group action
                },
                backgroundColor: Colors.orange,
                child: const Icon(Icons.add, size: 32),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SplitInNavBar(),
      ),
    );
  }
}
