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