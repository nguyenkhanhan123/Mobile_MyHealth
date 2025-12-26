class GetNutriMealRes {
  final String message;
  final NutriMeal? nutriMeal;

  GetNutriMealRes({
    required this.message,
    this.nutriMeal,
  });

  factory GetNutriMealRes.fromJson(Map<String, dynamic> json) {
    return GetNutriMealRes(
      message: json['message'] as String,
      nutriMeal: json['nutriMeal'] != null
          ? NutriMeal.fromJson(json['nutriMeal'])
          : null,
    );
  }
}

class NutriMeal {
  final double kcal;
  final double totalCarbs;
  final double carbs;
  final double sugar;
  final double fiber;
  final double protein;
  final double totalFats;
  final double saturatedFat;
  final double monounSaturatedFat;
  final double polyunSaturatedFat;
  final double transFat;
  final double cholesterol;
  final double vitaminA;
  final double vitaminC;
  final double vitaminD;
  final double vitaminB6;
  final double vitaminB12;
  final double vitaminE;
  final double vitaminK;
  final double choline;
  final double canxi;
  final double fe;
  final double magie;
  final double photpho;
  final double kali;
  final double natri;
  final double zn;
  final double water;
  final double caffeine;
  final double alcohol;

  NutriMeal({
    required this.kcal,
    required this.carbs,
    required this.totalCarbs,
    required this.sugar,
    required this.fiber,
    required this.protein,
    required this.totalFats,
    required this.saturatedFat,
    required this.monounSaturatedFat,
    required this.polyunSaturatedFat,
    required this.transFat,
    required this.cholesterol,
    required this.vitaminA,
    required this.vitaminC,
    required this.vitaminD,
    required this.vitaminB6,
    required this.vitaminB12,
    required this.vitaminE,
    required this.vitaminK,
    required this.choline,
    required this.canxi,
    required this.fe,
    required this.magie,
    required this.photpho,
    required this.kali,
    required this.natri,
    required this.zn,
    required this.water,
    required this.caffeine,
    required this.alcohol,
  });

  factory NutriMeal.fromJson(Map<String, dynamic> json) {
    return NutriMeal(
      kcal: (json['kcal'] as num?)?.toDouble() ?? 0.0,
      carbs: (json['carbs'] as num?)?.toDouble() ?? 0.0,
      totalCarbs: (json['totalCarbs'] as num?)?.toDouble() ?? 0.0,
      sugar: (json['sugar'] as num?)?.toDouble() ?? 0.0,
      fiber: (json['fiber'] as num?)?.toDouble() ?? 0.0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
      totalFats: (json['totalFats'] as num?)?.toDouble() ?? 0.0,
      saturatedFat: (json['saturatedFat'] as num?)?.toDouble() ?? 0.0,
      monounSaturatedFat: (json['monounSaturatedFat'] as num?)?.toDouble() ?? 0.0,
      polyunSaturatedFat: (json['polyunSaturatedFat'] as num?)?.toDouble() ?? 0.0,
      transFat: (json['transFat'] as num?)?.toDouble() ?? 0.0,
      cholesterol: (json['cholesterol'] as num?)?.toDouble() ?? 0.0,
      vitaminA: (json['vitaminA'] as num?)?.toDouble() ?? 0.0,
      vitaminC: (json['vitaminC'] as num?)?.toDouble() ?? 0.0,
      vitaminD: (json['vitaminD'] as num?)?.toDouble() ?? 0.0,
      vitaminB6: (json['vitaminB6'] as num?)?.toDouble() ?? 0.0,
      vitaminB12: (json['vitaminB12'] as num?)?.toDouble() ?? 0.0,
      vitaminE: (json['vitaminE'] as num?)?.toDouble() ?? 0.0,
      vitaminK: (json['vitaminK'] as num?)?.toDouble() ?? 0.0,
      choline: (json['choline'] as num?)?.toDouble() ?? 0.0,
      canxi: (json['canxi'] as num?)?.toDouble() ?? 0.0,
      fe: (json['fe'] as num?)?.toDouble() ?? 0.0,
      magie: (json['magie'] as num?)?.toDouble() ?? 0.0,
      photpho: (json['photpho'] as num?)?.toDouble() ?? 0.0,
      kali: (json['kali'] as num?)?.toDouble() ?? 0.0,
      natri: (json['natri'] as num?)?.toDouble() ?? 0.0,
      zn: (json['zn'] as num?)?.toDouble() ?? 0.0,
      water: (json['water'] as num?)?.toDouble() ?? 0.0,
      caffeine: (json['caffeine'] as num?)?.toDouble() ?? 0.0,
      alcohol: (json['alcohol'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
