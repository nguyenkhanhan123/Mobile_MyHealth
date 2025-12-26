class GetRequiredIndexRes {
  final String message;
  final RequiredIndex? requiredIndex;

  GetRequiredIndexRes({
    required this.message,
    this.requiredIndex,
  });

  factory GetRequiredIndexRes.fromJson(Map<String, dynamic> json) {
    return GetRequiredIndexRes(
      message: json['message'] as String,
      requiredIndex: json['requiredIndex'] != null
          ? RequiredIndex.fromJson(json['requiredIndex'])
          : null,
    );
  }
}

class RequiredIndex {
  final int id;
  final int userInfoId;
  final double bmr;
  final double tdee;
  final double targetCalories;
  final double water;
  final double protein;
  final double totalFat;
  final double saturatedFat;
  final double monounSaturatedFat;
  final double polyunSaturatedFat;
  final double transfat;
  final double carbohydrate;
  final double carbs;
  final double sugar;
  final double fiber;
  final double cholesterol;
  final double vitamina;
  final double vitamind;
  final double vitaminc;
  final double vitaminb6;
  final double vitaminb12;
  final double vitamine;
  final double vitamink;
  final double choline;
  final double canxi;
  final double fe;
  final double magie;
  final double photpho;
  final double kali;
  final double natri;
  final double zn;
  final double caffeine;
  final double alcohol;

  RequiredIndex({
    required this.id,
    required this.userInfoId,
    required this.bmr,
    required this.tdee,
    required this.targetCalories,
    required this.water,
    required this.protein,
    required this.totalFat,
    required this.saturatedFat,
    required this.monounSaturatedFat,
    required this.polyunSaturatedFat,
    required this.transfat,
    required this.carbohydrate,
    required this.carbs,
    required this.sugar,
    required this.fiber,
    required this.cholesterol,
    required this.vitamina,
    required this.vitamind,
    required this.vitaminc,
    required this.vitaminb6,
    required this.vitaminb12,
    required this.vitamine,
    required this.vitamink,
    required this.choline,
    required this.canxi,
    required this.fe,
    required this.magie,
    required this.photpho,
    required this.kali,
    required this.natri,
    required this.zn,
    required this.caffeine,
    required this.alcohol,
  });

  factory RequiredIndex.fromJson(Map<String, dynamic> json) {
    return RequiredIndex(
      id: json['id'] as int,
      userInfoId: json['userinfoid'] as int,
      bmr: (json['bmr'] as num).toDouble(),
      tdee: (json['tdee'] as num).toDouble(),
      targetCalories: (json['targetcalories'] as num).toDouble(),
      water: (json['water'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      totalFat: (json['totalfat'] as num).toDouble(),
      saturatedFat: (json['saturatedfat'] as num).toDouble(),
      monounSaturatedFat: (json['monounsaturatedfat'] as num).toDouble(),
      polyunSaturatedFat: (json['polyunsaturatedfat'] as num).toDouble(),
      transfat: (json['transfat'] as num).toDouble(),
      carbohydrate: (json['carbohydrate'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      sugar: (json['sugar'] as num).toDouble(),
      fiber: (json['fiber'] as num).toDouble(),
      cholesterol: (json['cholesterol'] as num).toDouble(),
      vitamina: (json['vitamina'] as num).toDouble(),
      vitamind: (json['vitamind'] as num).toDouble(),
      vitaminc: (json['vitaminc'] as num).toDouble(),
      vitaminb6: (json['vitaminb6'] as num).toDouble(),
      vitaminb12: (json['vitaminb12'] as num).toDouble(),
      vitamine: (json['vitamine'] as num).toDouble(),
      vitamink: (json['vitamink'] as num).toDouble(),
      choline: (json['choline'] as num).toDouble(),
      canxi: (json['canxi'] as num).toDouble(),
      fe: (json['fe'] as num).toDouble(),
      magie: (json['magie'] as num).toDouble(),
      photpho: (json['photpho'] as num).toDouble(),
      kali: (json['kali'] as num).toDouble(),
      natri: (json['natri'] as num).toDouble(),
      zn: (json['zn'] as num).toDouble(),
      caffeine: (json['caffeine'] as num).toDouble(),
      alcohol: (json['alcohol'] as num).toDouble(),
    );
  }
}
