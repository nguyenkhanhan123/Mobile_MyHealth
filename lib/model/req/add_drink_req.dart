class AddDrinkReq {
  final int userId;
  final int unitDrinkId;
  final double amount;
  final String date;

  AddDrinkReq({
    required this.userId,
    required this.unitDrinkId,
    required this.amount,
    required this.date
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'amount': amount,
      'unitDrinkId': unitDrinkId,
      'date': date
    };
  }
}
