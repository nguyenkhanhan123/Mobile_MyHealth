import 'get_meal_plan_res.dart';

class ReplaceMealRes {
  final String status;
  final ReplaceMealData? response;

  ReplaceMealRes({
    required this.status,
    this.response,
  });

  factory ReplaceMealRes.fromJson(Map<String, dynamic> json) {
    return ReplaceMealRes(
      status: json['status'] as String? ?? '',
      response: json['response'] != null
          ? ReplaceMealData.fromJson(json['response'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'response': response?.toJson(),
    };
  }
}

class ReplaceMealData {
  final MealItem? bestReplacement;

  ReplaceMealData({this.bestReplacement});

  factory ReplaceMealData.fromJson(Map<String, dynamic> json) {
    return ReplaceMealData(
      bestReplacement: json['best_replacement'] != null
          ? MealItem.fromJson(json['best_replacement'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'best_replacement': bestReplacement?.toJson(),
    };
  }
}