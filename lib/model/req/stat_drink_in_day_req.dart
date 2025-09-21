class StatDrinkInDayReq {
  final String date;
  final int userId;

  StatDrinkInDayReq({
    required this.date,
    required this.userId
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'userId': userId,
    };
  }
}
