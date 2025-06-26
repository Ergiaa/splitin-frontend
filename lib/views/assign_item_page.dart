import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Participant {
  final String id;
  final String name;
  final String email;
  bool isSelected;

  Participant({
    required this.id,
    required this.name,
    required this.email,
    this.isSelected = false,
  });
}

// Model untuk merepresentasikan setiap item dalam tagihan (sudah diperbarui)
class Item {
  final String name;
  final int quantity;
  final int price;

  Item({
    required this.name,
    required this.quantity,
    required this.price,
  });
  int get totalPrice => price * quantity;

  Map get toMap => {"name": name, "total_quantity": quantity, "unit_price": price};
}


// --- Halaman Utama (Screen) ---
class AssignItemScreen extends StatefulWidget {
  const AssignItemScreen({super.key});

  @override
  State<AssignItemScreen> createState() => _AssignItemScreenState();
}

class _AssignItemScreenState extends State<AssignItemScreen> {
  
  final List<Participant> _participants = [
    Participant(id: 'p1', name: 'user1', email: 'user1@email.com'),
    Participant(id: 'p2', name: 'user2', email: 'user2@email.com'),
    Participant(id: 'p3', name: 'user3', email: 'user3@email.com'),
  ];

  // Data Dummy diperbarui ke model Item
  final List<Item> _billItems = [
    Item(name: 'Donat', price: 12000, quantity: 4),
    Item(name: 'Es Buah', price: 10000, quantity: 4),
    Item(name: 'Tempe Coklat', price: 15000, quantity: 3),
  ];

  // Menyimpan peserta yang sedang dipilih
  late Participant _selectedParticipant;
  final Map<String, Set<String>> _assignments = {};

  // Formatter untuk mata uang Rupiah
  final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    // Inisialisasi state awal
    if (_participants.isNotEmpty) {
      _selectedParticipant = _participants.first;
    }
    // Inisialisasi map assignments untuk setiap peserta
    for (var p in _participants) {
      _assignments[p.id] = {};
    }
  }

  // Fungsi untuk menandai/membatalkan item untuk peserta yang dipilih (diperbarui ke model Item)
  void _toggleItemAssignment(Item item, bool? isSelected) {
    setState(() {
      final participantAssignments = _assignments[_selectedParticipant.id]!;
      if (isSelected == true) {
        participantAssignments.add(item.name);
      } else {
        participantAssignments.remove(item.name);
      }
    });
  }

  // --- UI BUILD METHODS ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Color(0xFF16A75C)),
        title: const Text(
          'Assign Item',
          style: TextStyle(
            color: Color(0xFF16A75C),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildParticipantsList(),
            const SizedBox(height: 16),
            _buildBillItemsList(),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  // WIDGET INI TELAH DIPERBAIKI
  Widget _buildParticipantsList() {
    return Container(
      height: 105, // Tinggi sedikit ditambah untuk ruang ekstra
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        // Menambahkan padding horizontal pada ListView agar simetris
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _participants.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final participant = _participants[index];
          final bool isSelected = participant.id == _selectedParticipant.id;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedParticipant = participant;
              });
            },
            // Memberi lebar yang konsisten pada setiap item
            child: SizedBox(
              width: 75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: isSelected ? 32 : 28,
                    backgroundColor: isSelected ? const Color(0xFF16A75C) : Colors.transparent,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey[300],
                      child: Text(
                        participant.name.isNotEmpty ? participant.name[0].toUpperCase() : '?',
                        style: const TextStyle(fontSize: 24, color: Colors.black54),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    participant.name,
                    maxLines: 1, // Mencegah teks turun ke baris baru
                    overflow: TextOverflow.ellipsis, // Menampilkan '...' jika teks terlalu panjang
                    textAlign: TextAlign.center, // Memusatkan teks
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBillItemsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _billItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = _billItems[index];
        // Logika penandaan disesuaikan untuk menggunakan item.name
        final bool isAssigned = _assignments[_selectedParticipant.id]!.contains(item.name);
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Kolom Nama & Harga Satuan
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(currencyFormatter.format(item.price)),
                  ],
                ),
              ),
              // Kolom Kuantitas
              Expanded(
                flex: 1,
                child: Center(
                  child: Text('${item.quantity}X', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                )
              ),
              // Kolom Total Harga & Checkbox
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(currencyFormatter.format(item.totalPrice), style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: isAssigned,
                        onChanged: (bool? value) => _toggleItemAssignment(item, value),
                        activeColor: const Color(0xFF16A75C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16).copyWith(
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                print('Assignments: $_assignments');
                Navigator.pushReplacementNamed(context, "/home");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A75C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
