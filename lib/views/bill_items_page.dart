import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/constants/splitin_colors.dart';
import 'package:splitin_frontend/models/item.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:intl/intl.dart';
import 'package:splitin_frontend/widgets/cart_list_item.dart';
import 'package:splitin_frontend/widgets/new_item_form.dart';

class BillItemsPage extends StatefulWidget {
  const BillItemsPage({super.key});

  @override
  State<StatefulWidget> createState() => _BillItemsPageState();
}

class _BillItemsPageState extends State<BillItemsPage> {
  final List<Item> _items = [];
  final formatCurrency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  late String _billID;
  List<Map> convertItemsToMap(List<Item> items) {
    List<Map> output = [];
    for (Item item in items) {
      output.add(item.toMap);
    }
    return output;
  }

  @override
  void initState() {
    super.initState();

    // Wait until widget is built, then show loader
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _showLoadingDialog();

      Map bill = await newBill();
      if (bill['data'] != null) {
        _billID = bill['data']['join_code'];
        log(_billID);
        addBillDialog(
          Text("New bill"),
          Icon(Icons.check, color: Colors.green),
          Text("Bill baru telah dibuat"),
          <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
                Navigator.of(context).pop(false);
              },
              child: Text("OK", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      } else {
        addBillDialog(
          Text("Error!!"),
          Icon(Icons.close_rounded, color: Colors.red),
          Text(bill['message']),
          <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                context.read<ProviderModel>().authController.deleteToken();
                Navigator.pushReplacementNamed(context, "/");
                context.read<ProviderModel>().clearAllForm();
                context.read<ProviderModel>().changeIndex(0);
              },
              child: Text("OK", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      }
    });
  }

  void addBillDialog(
    // Map bill,
    Text title,
    Icon title_icon,
    Text content,
    List<Widget> dialog_action,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              title_icon,
              SizedBox(width: 8),
              // Text("Error!!"),
              title,
            ],
          ),
          content: content,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: dialog_action,
        ),
      ),
    );
  }

  Future<Map> newBill() async {
    return await context.read<ProviderModel>().authController.createBill;
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Dialog(
          // The background color of the dialog
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The loading indicator
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                // The text
                const Text("Loading...", style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addItem(Item item) {
    setState(() {
      _items.add(item);
    });
  }

  void _showClearConfirmationDialog() {
    // Jangan tampilkan dialog jika keranjang sudah kosong
    if (_items.isEmpty) return;

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text(
            'Apakah Anda yakin ingin menghapus semua barang?',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            TextButton(
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
              onPressed: () {
                setState(() {
                  _items.clear();
                });
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomActionBar() {
    return Consumer<ProviderModel>(
      builder: (context, value, child) => Container(
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
                onPressed: _showClearConfirmationDialog,
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
                onPressed: () async {
                  if(_items.length == 0) return;
                  Map addItemToBill = await value.authController.addItemsToBill(
                    _billID,
                    convertItemsToMap(_items),
                  );
                  if (addItemToBill["data"] != null) {
                    addBillDialog(
                      Text("Berhasil"),
                      Icon(Icons.check, color: Colors.green),
                      Text("Item berhasil ditambahkan"),
                      <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            Navigator.pushNamed(
                              context,
                              "/bill-item/add-participants",
                            );
                            _items.clear();
                          },
                          child: Text(
                            "Lanjutkan",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  } else if (addItemToBill["statusCode"] == 403) {
                    addBillDialog(
                      Text("Terjadi Kesalahan"),
                      Icon(Icons.close, color: Colors.red),
                      Text("Item sudah ada"),
                      <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SplitinColors.orange_star_color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text(
                            "Kembali mengedit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  } else {
                    addBillDialog(
                      Text("Server Error"),
                      Icon(Icons.close, color: Colors.red),
                      Text(addItemToBill["message"]),
                      <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            value.authController.deleteToken();
                            Navigator.pushReplacementNamed(context,"/");
                          },
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  }
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ProviderModel>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Tambahkan Item",
            style: TextStyle(color: SplitinColors.green_button, fontWeight: FontWeight.bold),
            
          ),centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [
            // Expanded memastikan ListView mengambil semua ruang yang tersedia
            Expanded(
              child: ListView.builder(
                itemCount: _items.length + 1,
                itemBuilder: (context, index) {
                  // Jika index adalah item terakhir, tampilkan form
                  if (index == _items.length) {
                    return NewItemForm(
                      formatter: formatCurrency,
                      onAddItem: (item) {
                        _addItem(item);
                      },
                    );
                  } else {
                    // Jika tidak, tampilkan item list seperti biasa
                    final item = _items[index];
                    return CartListItem(item: item, formatter: formatCurrency);
                  }
                },
              ),
            ),

            _buildBottomActionBar(),
          ],
        ), // edit ini
      ),
    );
  }
}
