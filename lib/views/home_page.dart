import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/controllers/auth_controller.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/widgets/bottom_navigation_bar.dart';
import 'package:splitin_frontend/widgets/floating_action_button.dart';
import 'package:splitin_frontend/widgets/tagihan_home_card.dart';
import 'package:splitin_frontend/widgets/history_card.dart';
import 'package:splitin_frontend/models/bill_data.dart' as bill_data;
import 'package:splitin_frontend/models/bill_data.dart'
    show BillTransactionType;
import 'package:splitin_frontend/models/home_bill.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> ledgerData = [];
  List<BillModel> bills = [];
  int totalDebt = 0;
  int totalCredit = 0;

  @override
  void initState() {
    super.initState();
    fetchLedgers();
    fetchBills();
    fetchTotalLedgers();
  }

  Future<void> fetchLedgers() async {
    final response = await AuthController().getAllLedgers(
      1,
      10,
    ); // replace with your actual service class
    if (response['status'] == true) {
      setState(() {
        ledgerData = List<Map<String, dynamic>>.from(response['data']);
      });
    } else {
      // optionally show error
      print(response['message']);
    }
  }

  Future<void> fetchBills() async {
    final response = await AuthController().getAllBillForUser(1, 2);
    if (response['status'] == true) {
      setState(() {
        bills = (response['data'] as List)
            .map((item) => BillModel.fromJson(item))
            .toList();
      });
    } else {
      print(response['message']);
    }
  }

  Future<void> fetchTotalLedgers() async {
    final response = await AuthController()
        .getTotalLedgers(); // adjust if needed
    if (response['status'] == true) {
      final data = response['data'];
      setState(() {
        totalDebt = data['total_debt'];
        totalCredit = data['total_credit'];
      });
    } else {
      print(response['message']);
    }
  }

  List<Widget> buildLedgerHistoryCards() {
    return ledgerData.map((ledger) {
      final isPaid = ledger['is_paid'] == true;
      final isDebt = ledger['ledger_type'] == 'debt';
      final otherUser = isDebt
          ? ledger['creditor_user']
          : ledger['debtor_user'];

      final description = isDebt
          ? "Utang kamu ke ${otherUser['username'].isEmpty ? 'Temanmu' : otherUser['username']}"
          : "${otherUser['username'].isEmpty ? 'Temanmu' : otherUser['username']} utang ke kamu";

      return Column(
        children: [
          HistoryCard(
            title:
                ledger['bill_name'], // You could replace this with bill name if you have it
            date: formatDate(ledger['created_at']),
            description: description,
            totalAmount: "Rp ${formatCurrency(ledger['amount'])}",
            icon: Icons.receipt_long,
            iconColor: Colors.grey[700]!,
            iconBackgroundColor: Colors.grey[200]!,
            statusText: isPaid ? "Sudah Lunas" : "Belum Lunas",
            statusBackgroundColor: isPaid
                ? Colors.lightGreen[100]!
                : Colors.red[100]!,
            statusTextColor: isPaid
                ? Colors.lightGreen[800]!
                : Colors.red[800]!,
          ),
          const SizedBox(height: 20),
        ],
      );
    }).toList();
  }

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );
  }

  String formatDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate);
    return "${dateTime.day} ${_monthName(dateTime.month)} ${dateTime.year}";
  }

  String _monthName(int month) {
    const months = [
      "",
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          bool shouldExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Keluar Aplikasi'),
              content: Text('Apakah kamu yakin ingin keluar?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Tidak'),
                ),
                TextButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: Text('Iya'),
                ),
              ],
            ),
          );

          if (shouldExit) {
            Navigator.of(context).maybePop();
          }
        }
      },
      child: Consumer<ProviderModel>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.white,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: SizedBox(
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
                  padding: const EdgeInsets.only(
                    top: 60,
                    left: 20,
                    right: 20,
                    bottom: 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Beranda",
                        style: TextStyle(
                          color: Color(0xFF388E3C),
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
                            child: const Icon(
                              Icons.notifications_none,
                              color: Color(0xFF388E3C),
                              size: 35,
                            ),
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
                                Expanded(
                                  child: Text(
                                    "Rp ${formatCurrency(totalDebt)}", // ✅ Replace hardcoded debt
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(0, -30),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                      'assets/images/eyes.png',
                                      width: 100,
                                      height: 50,
                                      color: Colors.white,
                                      errorBuilder:
                                          (context, error, stackTrace) {
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
                            Text(
                              "Rp ${formatCurrency(totalCredit)}", // ✅ Replace hardcoded credit
                              style: const TextStyle(
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
                ),
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
                        onPressed: () {},
                        child: const Text(
                          "lihat semua",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ...(bills.isEmpty
                    ? [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Belum ada tagihan.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ]
                    : bills.map((bill) {
                        return Column(
                          children: [
                            TagihanHomeCard(
                              title: bill.billName,
                              date: formatDate(bill.createdAt),
                              totalAmount:
                                  "Rp ${formatCurrency(bill.totalPrice)}",
                              icon: Icons.receipt_long,
                              iconColor: const Color(0xFFB2DFDB),
                              iconBackgroundColor: const Color(0xFFE0F2F1),
                              participants: [
                                if (bill.totalCredit != 0)
                                  bill_data.BillParticipant(
                                    imageUrl: 'assets/images/person.jpeg',
                                    transactionType:
                                        BillTransactionType.owesYou,
                                    amount:
                                        'Rp ${formatCurrency(bill.totalCredit)}',
                                    tagBackgroundColor: Colors.green[100]!,
                                    tagTextColor: Colors.green[800]!,
                                  ),
                                if (bill.totalDebt != 0)
                                  bill_data.BillParticipant(
                                    imageUrl: 'assets/images/person.jpeg',
                                    transactionType: BillTransactionType.youOwe,
                                    amount:
                                        'Rp ${formatCurrency(bill.totalDebt)}',
                                    tagBackgroundColor: Colors.amber[100]!,
                                    tagTextColor: Colors.amber[800]!,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        );
                      }).toList()),

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
                        onPressed: () {},
                        child: const Text(
                          "lihat semua",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: buildLedgerHistoryCards()),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SplitInNavBar(),
        ),
      ),
    );
  }
}
