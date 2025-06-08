import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/widgets/home_page_body.dart';
import 'package:splitin_frontend/widgets/bottom_navigation_bar.dart';
import 'package:splitin_frontend/widgets/floating_action_button.dart';
import 'package:splitin_frontend/widgets/tagihan_home_card.dart';
import 'package:splitin_frontend/widgets/history_card.dart';
import 'package:splitin_frontend/models/bill_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final List<BillParticipant> baliTripParticipants = [
      BillParticipant(
        imageUrl: 'assets/images/person.jpeg',
        transactionType: BillTransactionType.owesYou,
        amount: 'Rp 15,000,000',
        tagBackgroundColor: Colors.green[100]!,
        tagTextColor: Colors.green[800]!,
      ),
    ];

    final List<BillParticipant> birthdayParticipants = [
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
    ];

    return Consumer<ProviderModel>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FittedBox(
            fit: BoxFit.fill,
            child: SplitinFloatingActionButton(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Beranda",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.notifications_none, color: Colors.black),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/person.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    color: const Color.fromARGB(255, 65, 128, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Hutang kamu",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Rp500,000",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              //
                              Transform.translate(
                                offset: const Offset(0, -30),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    'assets/images/eyes.png',
                                    width: 100,
                                    height: 50,
                                    color: Colors.white,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                        size: 24,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Total Piutang kamu",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Rp15,005,000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              ,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Tagihan tertunda",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                      },
                      child: const Text(
                        "lihat semua",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              TagihanHomeCard(
                title: "Bali Trip w/ the boys",
                date: "1 Juni 2025",
                totalAmount: "Rp 50,000,000",
                icon: Icons.beach_access,
                iconColor: const Color.fromARGB(255, 255, 165, 165),
                iconBackgroundColor: const Color.fromARGB(255, 255, 165, 165),
                participants: baliTripParticipants,
              ),

              const SizedBox(height: 30),


              TagihanHomeCard(
                title: "Birthday Surprise",
                date: "16 Mei 2025",
                totalAmount: "Rp 10,000,000",
                icon: Icons.cake,
                iconColor: const Color.fromARGB(255, 252, 230, 165),
                iconBackgroundColor: const Color.fromARGB(255, 252, 230, 165),
                participants: birthdayParticipants,
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Riwayat",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                      },
                      child: const Text(
                        "lihat semua",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              HistoryCard(
                title: "Nobar Jumbo",
                date: "21 Mei 2025",
                description: "Utang kamu ke Tony Stark",
                totalAmount: "Rp 100,000",
                icon: Icons.movie,
                iconColor: Colors.grey[700]!,
                iconBackgroundColor: Colors.grey[200]!,
                statusText: "Sudah Lunas",
                statusBackgroundColor: Colors.lightGreen[100]!,
                statusTextColor: Colors.lightGreen[800]!,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: SplitInNavBar(),
      ),
    );
  }
}