import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/models/provider.dart';

class SplitinColors {
  static const Color green_button = Color(0xFF25D366);
  static const Color orange_star_color = Colors.orange;
}

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

class Group {
  final String id;
  final String name;
  final List<Participant> members;

  Group({required this.id, required this.name, required this.members});
}
// --------------------------------------------------------------------

class ParticipantSelectorScreen extends StatefulWidget {
  const ParticipantSelectorScreen({super.key});

  @override
  State<ParticipantSelectorScreen> createState() =>
      _ParticipantSelectorScreenState();
}

class _ParticipantSelectorScreenState extends State<ParticipantSelectorScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Group> _allGroups = [
    Group(id: "1", name: 'Tim Marketing', members: []),
    Group(id: "2", name: 'Developer Frontend', members: []),
    Group(id: "3", name: 'Projek Alfa', members: []),
    Group(id: "4", name: 'Panitia Event', members: []),
  ];
  Group? _selectedGroup;
  late List<Group> _filteredGroups;

  final List<Participant> _allParticipants = [
  ];

  late List<Participant> _selectedParticipants;
  late List<Participant> _filteredParticipants;
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      
        Map allUser = await context
            .read<ProviderModel>()
            .authController
            .getAllUser;
        Map getSession = await context
            .read<ProviderModel>()
            .authController
            .getUserSession;
        if (allUser["data"] != null) {
          for (Map user in allUser["data"]) {
            if (user["id"] != getSession["data"]["id"]) {
              print("user ${user}");
              _allParticipants.add(
                Participant(
                  id: user["id"],
                  name: user["username"],
                  email: user["email"],
                  isSelected: false,
                ),
              );
            }
          }
        }
    });

    _tabController = TabController(length: 2, vsync: this);

    // Inisialisasi daftar peserta yang dipilih dari data awal
    _selectedParticipants = _allParticipants
        .where((p) => p.isSelected)
        .toList();
    _filteredParticipants = _allParticipants;
    _filteredGroups = _allGroups;
    _searchController.addListener(_filterLists);

    _tabController.addListener(() {
      // Panggil setState untuk membangun ulang UI saat tab berubah
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // Pastikan listener dihapus untuk menghindari memory leak
    _tabController.removeListener(() {});
    _tabController.dispose();
    _searchController.removeListener(_filterLists);
    _searchController.dispose();
    super.dispose();
  }

  void _filterLists() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredParticipants = _allParticipants.where((participant) {
        return participant.name.toLowerCase().contains(query) ||
            participant.email.toLowerCase().contains(query);
      }).toList();

      _filteredGroups = _allGroups.where((group) {
        return group.name.toLowerCase().contains(query);
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

  void _toggleGroupSelection(Group group) {
    setState(() {
      if (_selectedGroup?.id == group.id) {
        _selectedGroup = null;
      } else {
        _selectedGroup = group;
      }
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          FocusScope.of(context).requestFocus(FocusNode());
        });
      }
    });
  }

  void _clearAllSelections() {
    setState(() {
      for (var p in _selectedParticipants) {
        p.isSelected = false;
      }
      _selectedParticipants.clear();
      _selectedGroup = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: _isSearching
            ? IconButton(
                icon: const Icon(Icons.close, color: Colors.black54),
                onPressed: _toggleSearch,
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black54),
                onPressed: () => Navigator.of(context).pop(),
              ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Cari nama pengguna atau grup...',
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black87, fontSize: 16),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Pilih Peserta',
                    style: TextStyle(
                      color: SplitinColors.green_button,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${_selectedParticipants.length} dari ${_allParticipants.length} dipilih',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
        centerTitle: true,
        actions: _isSearching
            ? []
            : [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black54),
                  onPressed: _toggleSearch,
                ),
              ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: SplitinColors.green_button,
          unselectedLabelColor: Colors.grey,
          indicatorColor: SplitinColors.green_button,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: "Grup"),
            Tab(text: "Pengguna"),
          ],
        ),
      ),
      body: Column(
        children: [
          if (_tabController.index == 0) ...[
            _buildSelectedParticipantsList(),
            if (_selectedParticipants.isNotEmpty)
              const Divider(height: 1, thickness: 1),
          ],
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildGroupsTab(), _buildParticipantsTab()],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  Widget _buildParticipantsTab() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: _filteredParticipants.length,
      itemBuilder: (context, index) {
        final participant = _filteredParticipants[index];
        return _buildParticipantListItem(participant);
      },
    );
  }

  Widget _buildGroupsTab() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: _filteredGroups.length,
      itemBuilder: (context, index) {
        final group = _filteredGroups[index];
        return _buildGroupListItem(group);
      },
    );
  }

  Widget _buildSelectedParticipantsList() {
    if (_selectedParticipants.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      height: 105,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedParticipants.length,
        itemBuilder: (context, index) {
          final participant = _selectedParticipants[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundImage: AssetImage("assets/images/person.jpeg"),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: GestureDetector(
                        onTap: () => _toggleSelection(participant),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 60,
                  child: Text(
                    participant.name.split(' ').first,
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
        alignment: Alignment.bottomRight,
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/images/person.jpeg"),
          ),
          if (participant.isSelected)
            const CircleAvatar(
              radius: 10,
              backgroundColor: SplitinColors.green_button,
              child: Icon(Icons.check, size: 14, color: Colors.white),
            ),
        ],
      ),
      title: Text(
        participant.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        participant.email,
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildGroupListItem(Group group) {
    final bool isSelected = _selectedGroup?.id == group.id;
    return ListTile(
      onTap: () => _toggleGroupSelection(group),
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.group, color: Colors.white),
          ),
          if (isSelected)
            const CircleAvatar(
              radius: 10,
              backgroundColor: SplitinColors.green_button,
              child: Icon(Icons.check, size: 14, color: Colors.white),
            ),
        ],
      ),
      title: Text(
        group.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '${group.members.length} anggota',
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ).copyWith(bottom: MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.delete_outline),
              label: const Text('Clear All'),
              onPressed: _clearAllSelections,
              style: OutlinedButton.styleFrom(
                foregroundColor: SplitinColors.orange_star_color,
                side: const BorderSide(color: SplitinColors.orange_star_color),
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
                
                Navigator.pushReplacementNamed(context, "/bill-item/add-participants/assign-item");
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
}
