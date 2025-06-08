import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/widgets/bottom_navigation_bar.dart';
import 'package:splitin_frontend/widgets/floating_action_button.dart';
import 'package:splitin_frontend/widgets/history_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with TickerProviderStateMixin {
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
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Riwayat",
                  style: TextStyle(
                    color: Color(0xFF388E3C),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // TODO: handle filter action
                      },
                      icon: const Icon(Icons.filter_list),
                      color: Color(0xFF388E3C),
                      iconSize: 35,
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: handle search action
                      },
                      icon: const Icon(Icons.search),
                      color: Color(0xFF388E3C),
                      iconSize: 35,
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: const [
              Tab(text: "Hutang"),
              Tab(text: "Piutang"),
            ],
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
        bottomNavigationBar: SplitInNavBar(),
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: 2,
              itemBuilder: (context, index) {
                final cards = [
                  const HistoryCard(
                    title: "Nobar Jumbo",
                    date: "21 Mei 2025",
                    description: "Utang kamu ke Tony Stark",
                    totalAmount: "Rp 100.000",
                    icon: Icons.movie,
                    iconColor: Colors.white,
                    iconBackgroundColor: Colors.orange,
                    statusText: "Sudah Lunas",
                    statusBackgroundColor: Color(0xFFDFF5E3),
                    statusTextColor: Color(0xFF4CAF50),
                  ),
                  const HistoryCard(
                    title: "Telur gulung depan ITS",
                    date: "30 Mei 2025",
                    description: "Utang kamu ke Amba",
                    totalAmount: "Rp 1.000.000",
                    icon: Icons.fastfood,
                    iconColor: Colors.white,
                    iconBackgroundColor: Colors.orange,
                    statusText: "Sudah Lunas",
                    statusBackgroundColor: Color(0xFFDFF5E3),
                    statusTextColor: Color(0xFF4CAF50),
                  ),
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
                  const HistoryCard(
                    title: "Bensin bareng",
                    date: "4 Juni 2025",
                    description: "Piutang dari Budi",
                    totalAmount: "Rp 45.000",
                    icon: Icons.local_gas_station,
                    iconColor: Colors.white,
                    iconBackgroundColor: Colors.blue,
                    statusText: "Belum Lunas",
                    statusBackgroundColor: Color(0xFFFFF3E0),
                    statusTextColor: Color(0xFFFF9800),
                  ),
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
