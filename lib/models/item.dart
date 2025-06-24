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

  Map get toMap => {"name":name, "total_quantity":quantity, "unit_price":price};
}
