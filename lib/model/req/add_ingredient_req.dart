class AddIngredientReq {
  final String name;
  final String? thumbnail;
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

  AddIngredientReq({
    required this.name,
    this.thumbnail,
    required this.baseUnit,
    required this.gramPerUnit,
    this.isConfirm = 0,
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
    required this.alcohol
  });

  Map<String, dynamic> toMap() {
    return {
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
      'alcohol': alcohol
    };
  }
}
