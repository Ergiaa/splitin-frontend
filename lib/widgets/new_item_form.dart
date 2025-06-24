
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splitin_frontend/models/item.dart';

class NewItemForm extends StatefulWidget {
  final NumberFormat formatter;
  final Function(Item) onAddItem;

  const NewItemForm({
    super.key,
    required this.formatter,
    required this.onAddItem,
  });

  @override
  State<NewItemForm> createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  int _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _priceController.addListener(_updateTotal);
    _quantityController.addListener(_updateTotal);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _updateTotal() {
    final price = int.tryParse(_priceController.text) ?? 0;
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    setState(() {
      _totalPrice = price * quantity;
    });
  }

  // Fungsi untuk memvalidasi dan mengirim data
  void _submitData() {
    final name = _nameController.text;
    final price = int.tryParse(_priceController.text);
    final quantity = int.tryParse(_quantityController.text);

    if (name.isEmpty ||
        price == null ||
        quantity == null ||
        price <= 0 ||
        quantity <= 0) {
      // Jika data tidak valid, jangan lakukan apa-apa.
      // Anda bisa menambahkan dialog error di sini.
      return;
    }

    // Panggil callback untuk menambahkan item ke list utama
    widget.onAddItem(Item(name: name, price: price, quantity: quantity));

    // Kosongkan field setelah item ditambahkan
    _nameController.clear();
    _priceController.clear();
    _quantityController.clear();
    FocusScope.of(context).unfocus(); // Tutup keyboard
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            // offset: const Offset(0, -5), // Shadow di bagian atas
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nama Barang',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: 'Masukkan nama barang',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormColumn('Harga Barang', _priceController, isPrice: true),
              const SizedBox(width: 12),
              _buildFormColumn('Jumlah Barang', _quantityController),
              const SizedBox(width: 12),
              _buildTotalColumn(),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _submitData,
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Tambah Barang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5893C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
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

  // Helper widget untuk membuat kolom input harga dan jumlah
  Widget _buildFormColumn(
    String title,
    TextEditingController controller, {
    bool isPrice = false,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: '0',
              suffixText: isPrice ? '' : 'X',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget untuk kolom total
  Widget _buildTotalColumn() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total harga',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.formatter.format(_totalPrice),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}