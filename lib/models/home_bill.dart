class BillParticipant {
  final String id;
  final String username;
  final String email;
  final String phoneNumber;

  BillParticipant({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
  });

  factory BillParticipant.fromJson(Map<String, dynamic> json) {
    return BillParticipant(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }
}

class BillModel {
  final String billName;
  final int totalPrice;
  final int totalDebt;
  final int totalCredit;
  final String createdAt;
  final List<BillParticipant> participants;

  BillModel({
    required this.billName,
    required this.totalPrice,
    required this.totalDebt,
    required this.totalCredit,
    required this.createdAt,
    required this.participants,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      billName: json['bill_name'],
      totalPrice: json['total_price'],
      totalDebt: json['total_debt'],
      totalCredit: json['total_credit'],
      createdAt: json['created_at'],
      participants: (json['participants'] as List)
          .map((p) => BillParticipant.fromJson(p))
          .toList(),
    );
  }
}
