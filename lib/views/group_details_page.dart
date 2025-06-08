import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/bill_data.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/widgets/bottom_navigation_bar.dart';
import 'package:splitin_frontend/widgets/floating_action_button.dart';
import 'package:splitin_frontend/widgets/history_card.dart';
import 'package:splitin_frontend/widgets/tagihan_home_card.dart';

class GroupDetailsPage extends StatefulWidget {
  const GroupDetailsPage({super.key});

  @override
  State<StatefulWidget> createState() => _GroupDetailsPageState();
}

class _GroupDetailsPageState extends State<GroupDetailsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderModel>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),

            child: Text(
              "Bills",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF388E3C),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: const [
              Tab(text: "Lunas"),
              Tab(text: "Tertunda"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: 2,
              itemBuilder: (context, index) {
                final cards = [
                  TagihanHomeCard(
                    title: "Hawaiii 2024",
                    date: "1 Agustus 2025",
                    totalAmount: "70,000,000",
                    icon: Icons.h_mobiledata,
                    iconColor: Colors.white,
                    iconBackgroundColor: Color.fromARGB(255, 242, 170, 237),
                    participants: [
                    ],
                  ),
                  TagihanHomeCard(
                    title: "Bali Trip w/ the boys",
                    date: "1 Juni 2025",
                    totalAmount: "150,000,000",
                    icon: Icons.lte_mobiledata_rounded,
                    iconColor: Colors.white,
                    iconBackgroundColor: Color.fromARGB(255, 242, 170, 237),
                    participants: [
                    ],
                  )
                ];
                return cards[index];
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
            ),
            ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: 1,
              itemBuilder: (context, index) {
                final cards = [
                  TagihanHomeCard(
                    title: "Ciledug Trips",
                    date: "2 December 2024",
                    totalAmount: "40,000,000",
                    icon: Icons.abc,
                    iconColor: Colors.white,
                    iconBackgroundColor: Color.fromARGB(255, 242, 170, 237),
                    participants: [
                      BillParticipant(
                        imageUrl: 'assets/images/person.jpeg',
                        transactionType: BillTransactionType.youOwe,
                        amount: 'Rp 500,000',
                        tagBackgroundColor: Colors.amber[100]!,
                        tagTextColor: Colors.amber[800]!,
                      ),
                      BillParticipant(
                        imageUrl: 'assets/images/person.jpeg',
                        transactionType: BillTransactionType.owesYou,
                        amount: 'Rp 5,000',
                        tagBackgroundColor: Colors.green[100]!,
                        tagTextColor: Colors.green[800]!,
                      ),
                    ],
                  ),
                  TagihanHomeCard(
                    title: "Bali Trip w/ the boys",
                    date: "1 Juni 2025",
                    totalAmount: "150,000,000",
                    icon: Icons.abc,
                    iconColor: Colors.white,
                    iconBackgroundColor: Color.fromARGB(255, 242, 170, 237),
                    participants: [
                      BillParticipant(
                        imageUrl: 'assets/images/person.jpeg',
                        transactionType: BillTransactionType.youOwe,
                        amount: 'Rp 500,000',
                        tagBackgroundColor: Colors.amber[100]!,
                        tagTextColor: Colors.amber[800]!,
                      ),
                      BillParticipant(
                        imageUrl: 'assets/images/person.jpeg',
                        transactionType: BillTransactionType.owesYou,
                        amount: 'Rp 5,000',
                        tagBackgroundColor: Colors.green[100]!,
                        tagTextColor: Colors.green[800]!,
                      ),
                    ],
                  )
                ];
                return cards[index];
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
