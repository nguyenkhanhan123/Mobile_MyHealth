class GetTotalWaterRes {
  final String message;
  final double totalWater;

  GetTotalWaterRes({required this.message,required this.totalWater});

  factory GetTotalWaterRes.fromJson(Map<String, dynamic> json) {
    return GetTotalWaterRes(
      message: json['message'] as String,
      totalWater: (json['totalWater'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
