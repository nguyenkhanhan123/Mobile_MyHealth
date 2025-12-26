class GetTotalWaterReq {
  final String date;
  final int userId;

  GetTotalWaterReq({
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
