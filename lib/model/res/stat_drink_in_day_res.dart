class StatDrinkInDayRes {
  final String message;
  final List<InfoDrinkInDay> list;

  StatDrinkInDayRes({required this.message, required this.list});

  factory StatDrinkInDayRes.fromJson(Map<String, dynamic> json) {
    return StatDrinkInDayRes(
      message: json['message'] as String,
      list:
          (json['statDrinks'] as List<dynamic>)
              .map((item) => InfoDrinkInDay.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
}
}

class InfoDrinkInDay {
  final int id;
  final double amount;
  final String baseUnit;
  final String thumbnail;
  final DateTime createdAt;

  InfoDrinkInDay({
    required this.id,
    required this.amount,
    required this.baseUnit,
    required this.thumbnail,
    required this.createdAt,
  });

  factory InfoDrinkInDay.fromJson(Map<String, dynamic> json) {
    return InfoDrinkInDay(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      baseUnit: json['baseUnit'] as String,
      thumbnail: json['thumbnail'] as String,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

