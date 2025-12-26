class InfoIngredientRes {
  final String message;
  final Ingredient ingredient;

  InfoIngredientRes({
    required this.message,
    required this.ingredient,
  });

  factory InfoIngredientRes.fromJson(Map<String, dynamic> json) {
    return InfoIngredientRes(
      message: json['message'] as String,
      ingredient: Ingredient.fromJson(json['ingredient']),
    );
  }
}

class Ingredient {
  final int id;
  final String name;
  final String thumbnail;
  final String baseUnit;
  final double gramPerUnit;
  final int isConfirm;

  final int kcal;
  final double carbs;
  final double sugar;
  final double fiber;
  final double protein;

  final double saturatedFat;
  final double monounSaturatedFat;
  final double polyunSaturatedFat;
  final double transFat;
  final double cholesterol;

  final double vitaminA;
  final double vitaminD;
  final double vitaminC;
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

  Ingredient({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.baseUnit,
    required this.gramPerUnit,
    required this.isConfirm,
    required this.kcal,
    required this.carbs,
    required this.sugar,
    required this.fiber,
    required this.protein,
    required this.saturatedFat,
    required this.monounSaturatedFat,
    required this.polyunSaturatedFat,
    required this.transFat,
    required this.cholesterol,
    required this.vitaminA,
    required this.vitaminD,
    required this.vitaminC,
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

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      thumbnail: json['thumbnail'],
      baseUnit: json['baseUnit'],
      gramPerUnit: (json['gramPerUnit'] as num).toDouble(),
      isConfirm: json['isConfirm'],
      kcal: json['kcal'],
      carbs: (json['carbs'] as num).toDouble(),
      sugar: (json['sugar'] as num).toDouble(),
      fiber: (json['fiber'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      saturatedFat: (json['saturatedFat'] as num).toDouble(),
      monounSaturatedFat: (json['monounSaturatedFat'] as num).toDouble(),
      polyunSaturatedFat: (json['polyunSaturatedFat'] as num).toDouble(),
      transFat: (json['transFat'] as num).toDouble(),
      cholesterol: (json['cholesterol'] as num).toDouble(),
      vitaminA: (json['vitaminA'] as num).toDouble(),
      vitaminD: (json['vitaminD'] as num).toDouble(),
      vitaminC: (json['vitaminC'] as num).toDouble(),
      vitaminB6: (json['vitaminB6'] as num).toDouble(),
      vitaminB12: (json['vitaminB12'] as num).toDouble(),
      vitaminE: (json['vitaminE'] as num).toDouble(),
      vitaminK: (json['vitaminK'] as num).toDouble(),
      choline: (json['choline'] as num).toDouble(),
      canxi: (json['canxi'] as num).toDouble(),
      fe: (json['fe'] as num).toDouble(),
      magie: (json['magie'] as num).toDouble(),
      photpho: (json['photpho'] as num).toDouble(),
      kali: (json['kali'] as num).toDouble(),
      natri: (json['natri'] as num).toDouble(),
      zn: (json['zn'] as num).toDouble(),
      water: (json['water'] as num).toDouble(),
      caffeine: (json['caffeine'] as num).toDouble(),
      alcohol: (json['alcohol'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'baseUnit': baseUnit,
      'gramPerUnit': gramPerUnit,
      'isConfirm': isConfirm,
      'kcal': kcal,
      'carbs': carbs,
      'sugar': sugar,
      'fiber': fiber,
      'protein': protein,
      'saturatedFat': saturatedFat,
      'monounSaturatedFat': monounSaturatedFat,
      'polyunSaturatedFat': polyunSaturatedFat,
      'transFat': transFat,
      'cholesterol': cholesterol,
      'vitaminA': vitaminA,
      'vitaminD': vitaminD,
      'vitaminC': vitaminC,
      'vitaminB6': vitaminB6,
      'vitaminB12': vitaminB12,
      'vitaminE': vitaminE,
      'vitaminK': vitaminK,
      'choline': choline,
      'canxi': canxi,
      'fe': fe,
      'magie': magie,
      'photpho': photpho,
      'kali': kali,
      'natri': natri,
      'zn': zn,
      'water': water,
      'caffeine': caffeine,
      'alcohol': alcohol,
    };
  }
}
