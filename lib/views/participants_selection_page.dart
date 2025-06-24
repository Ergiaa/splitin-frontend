import 'package:flutter/material.dart';
import 'package:splitin_frontend/constants/splitin_colors.dart';
import 'package:splitin_frontend/models/participant.dart';



// Model untuk data peserta



// Screen utama untuk memilih peserta
class ParticipantSelectorScreen extends StatefulWidget {
  const ParticipantSelectorScreen({super.key});

  @override
  State<ParticipantSelectorScreen> createState() =>
      _ParticipantSelectorScreenState();
}

class _ParticipantSelectorScreenState extends State<ParticipantSelectorScreen> {
  // Daftar semua peserta (data dummy)
  final List<Participant> _allParticipants = [
    Participant(id: 1, name: "Ranoppu", email: "ranopGuy@email.com",isSelected: true),
    Participant(id: 2, name: "Run nope", email: "Ranov@email.com",  isSelected: true),
    Participant(id: 4, name: "Nopp", email: "ranovi@email.com", ),
  ];

  late List<Participant> _selectedParticipants;
  // List untuk menampung hasil filter pencarian
  late List<Participant> _filteredParticipants;
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _selectedParticipants = _allParticipants.where((p) => p.isSelected).toList();
    _filteredParticipants = _allParticipants;
    _searchController.addListener(_filterParticipants);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Fungsi untuk memfilter daftar peserta
  void _filterParticipants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredParticipants = _allParticipants.where((participant) {
        return participant.name.toLowerCase().contains(query);
      }).toList();
    });
  }
  
  void _toggleSelection(Participant participant) {
    setState(() {
      participant.isSelected = !participant.isSelected;
      if (participant.isSelected) {
        if (!_selectedParticipants.any((p) => p.id == participant.id)) {
          _selectedParticipants.add(participant);
        }
      } else {
        _selectedParticipants.removeWhere((p) => p.id == participant.id);
      }
    });
  }
  
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      }
    });
  }
Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)
          .copyWith(
            bottom: MediaQuery.of(context).padding.bottom + 12,
          ), // Padding aman untuk area bawah
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.delete_sweep_outlined),
              label: const Text('Clear All'),
              onPressed: (){},
              // onPressed: _showClearConfirmationDialog,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: SplitinColors.orange_star_color,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Confirm'),
              onPressed: () {
                // Aksi untuk konfirmasi, misalnya menyimpan ke database atau mencetak struk
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text('Pesanan berhasil dikonfirmasi!'),
                //     backgroundColor: Colors.green,
                //   ),
                // );
                Navigator.pushReplacementNamed(context, "/bill-item/add-participants");
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: SplitinColors.green_button,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching 
          ? IconButton(icon: const Icon(Icons.close), onPressed: _toggleSearch)
          : IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: _isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pilih Peserta', style: TextStyle(color: SplitinColors.green_button, fontWeight: FontWeight.bold)),
                Text(
                  '${_selectedParticipants.length} of ${_allParticipants.length} selected',
                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),centerTitle: true,
        actions: _isSearching
          ? []
          : [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: _toggleSearch,
              ),
            ],
      ),
      body: Column(
        children: [
          _buildSelectedParticipantsList(),
          if (_selectedParticipants.isNotEmpty)
            Container(height: 1, color: Colors.grey[800]),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredParticipants.length,
              itemBuilder: (context, index) {
                final participant = _filteredParticipants[index];
                return _buildParticipantListItem(participant);
              },
            ),
          ),
          _buildBottomActionBar()
        ],
      ),
    );
  }

  Widget _buildSelectedParticipantsList() {
    if (_selectedParticipants.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedParticipants.length,
        itemBuilder: (context, index) {
          final participant = _selectedParticipants[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      // backgroundImage: NetworkImage(participant.imageUrl),
                      backgroundImage: AssetImage("assets/images/person.jpeg"),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: GestureDetector(
                        onTap: () => _toggleSelection(participant),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF1F1F1F), width: 2)
                          ),
                          child: const Icon(Icons.close, size: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 60,
                  child: Text(
                    participant.name.split(' ')[0],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildParticipantListItem(Participant participant) {
    return ListTile(
      onTap: () => _toggleSelection(participant),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/images/person.jpeg"),
            onBackgroundImageError: (exception, stackTrace) {
               // Handle error jika gambar gagal dimuat
            },
          ),
          if (participant.isSelected)
            const Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Color(0xFF25D366),
                child: Icon(Icons.check, size: 14, color: Colors.white),
              ),
            ),
        ],
      ),
      title: Text(participant.name, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(participant.email, style: TextStyle(color: Colors.grey[400])),
    );
  }
}
