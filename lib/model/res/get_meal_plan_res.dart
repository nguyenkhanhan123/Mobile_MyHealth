class GetMealPlanRes {
  final String status;
  final MealPlanResponse? response;

  GetMealPlanRes({
    this.status = '',
    this.response,
  });

  factory GetMealPlanRes.fromJson(Map<String, dynamic> json) {
    return GetMealPlanRes(
      status: json['status'] as String? ?? '',
      response: json['response'] != null
          ? MealPlanResponse.fromJson(json['response'])
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

class MealPlanResponse {
  final List<MealSession> meals;
  final String reason;

  MealPlanResponse({
    required this.meals,
    required this.reason,
  });

  factory MealPlanResponse.fromJson(Map<String, dynamic> json) {
    List<MealSession> generatedSessions = [];

    if (json['final_menu'] != null) {
      var rawMenu = json['final_menu'] as List;
      Map<String, List<MealItem>> groupedItems = {};

      for (var itemJson in rawMenu) {
        // Sử dụng assigned_meal để group, nếu không có thì mặc định là 'Khác'
        String sessionName = itemJson['assigned_meal'] ?? 'Khác';
        if (!groupedItems.containsKey(sessionName)) {
          groupedItems[sessionName] = [];
        }
        groupedItems[sessionName]!.add(MealItem.fromJson(itemJson));
      }

      // Sắp xếp thứ tự bữa ăn
      List<String> order = ['sáng', 'trưa', 'tối', 'phụ'];
      for (var name in order) {
        if (groupedItems.containsKey(name)) {
          generatedSessions.add(MealSession(mealName: name, items: groupedItems[name]!));
          groupedItems.remove(name);
        }
      }
      // Thêm các bữa còn lại (nếu có)
      groupedItems.forEach((key, value) {
        generatedSessions.add(MealSession(mealName: key, items: value));
      });
    }

    return MealPlanResponse(
      meals: generatedSessions,
      reason: json['reason'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> flatMenu = [];

    for (var session in meals) {
      for (var item in session.items) {
        var itemJson = item.toJson();
        // Đảm bảo assigned_meal đúng với session hiện tại khi convert ngược lại
        itemJson['assigned_meal'] = session.mealName;
        flatMenu.add(itemJson);
      }
    }

    return {
      'final_menu': flatMenu,
      'reason': reason,
    };
  }
}

class MealSession {
  final String mealName;
  final List<MealItem> items;

  MealSession({
    required this.mealName,
    required this.items,
  });

  factory MealSession.fromJson(Map<String, dynamic> json) {
    return MealSession(
      mealName: json['meal_name'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => MealItem.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meal_name': mealName,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

class MealItem {
  // --- Identifiers & Basic Info ---
  final int mealId;
  final String name;
  final String assignedMeal; // Lưu lại giá trị gốc từ JSON
  final String mealTypeTag;
  final String role;

  // --- Detailed Info ---
  final List<String> ingredients;
  final String ingredientsText;
  final List<String> tags; // Mới thêm
  final String preparationSteps; // Mới thêm
  final String cookingSteps; // Mới thêm
  final String retrievalVibe; // Mới thêm

  // --- Metrics & Scoring ---
  final int healthScore; // Mới thêm
  final String scoreReason; // Mới thêm
  final double portionScale; // Mới thêm
  final List<double> solverBounds; // Mới thêm

  // --- Nutrition (Base & Final) ---
  // Final values (thường dùng để hiển thị sau khi scale)
  final double finalKcal;
  final double finalCarbs;
  final double finalProtein;
  final double finalTotalFat;

  // Base values (dinh dưỡng gốc 1 khẩu phần)
  final double kcal;
  final double totalCarbs;
  final double sugar;
  final double fiber;
  final double protein;
  final double totalFats;

  // Fats breakdown
  final double saturatedFat;
  final double monounSaturatedFat;
  final double polyunSaturatedFat;
  final double transFat;
  final double cholesterol;

  // Vitamins & Minerals
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

  // Others
  final double water;
  final double caffeine;
  final double alcohol;

  MealItem({
    required this.mealId,
    required this.name,
    required this.assignedMeal,
    required this.mealTypeTag,
    required this.role,
    required this.ingredients,
    required this.ingredientsText,
    required this.tags,
    required this.preparationSteps,
    required this.cookingSteps,
    required this.retrievalVibe,
    required this.healthScore,
    required this.scoreReason,
    required this.portionScale,
    required this.solverBounds,
    required this.finalKcal,
    required this.finalCarbs,
    required this.finalProtein,
    required this.finalTotalFat,
    required this.kcal,
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

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      mealId: (json['meal_id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      assignedMeal: json['assigned_meal'] as String? ?? '',
      mealTypeTag: json['meal_type_tag'] as String? ?? '',
      role: json['role'] as String? ?? '',

      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      ingredientsText: json['ingredients_text'] as String? ?? '',

      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],

      preparationSteps: json['preparation_steps'] as String? ?? '',
      cookingSteps: json['cooking_steps'] as String? ?? '',
      retrievalVibe: json['retrieval_vibe'] as String? ?? '',

      healthScore: (json['health_score'] as num?)?.toInt() ?? 0,
      scoreReason: json['score_reason'] as String? ?? '',
      portionScale: (json['portion_scale'] as num?)?.toDouble() ?? 1.0,

      solverBounds: (json['solver_bounds'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList() ?? [],

      // Final Values (scaled)
      finalKcal: (json['final_kcal'] as num?)?.toDouble() ?? 0.0,
      finalCarbs: (json['final_carbs'] as num?)?.toDouble() ?? 0.0,
      finalProtein: (json['final_protein'] as num?)?.toDouble() ?? 0.0,
      finalTotalFat: (json['final_totalfat'] as num?)?.toDouble() ?? 0.0,

      // Base Values
      kcal: (json['kcal'] as num?)?.toDouble() ?? 0.0,
      totalCarbs: (json['carbs'] as num?)?.toDouble() ?? 0.0,
      sugar: (json['sugar'] as num?)?.toDouble() ?? 0.0,
      fiber: (json['fiber'] as num?)?.toDouble() ?? 0.0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
      totalFats: (json['totalfat'] as num?)?.toDouble() ?? 0.0,

      saturatedFat: (json['saturatedfat'] as num?)?.toDouble() ?? 0.0,
      monounSaturatedFat: (json['monounsaturatedfat'] as num?)?.toDouble() ?? 0.0,
      polyunSaturatedFat: (json['polyunsaturatedfat'] as num?)?.toDouble() ?? 0.0,
      transFat: (json['transfat'] as num?)?.toDouble() ?? 0.0,
      cholesterol: (json['cholesterol'] as num?)?.toDouble() ?? 0.0,

      vitaminA: (json['vitamina'] as num?)?.toDouble() ?? 0.0,
      vitaminC: (json['vitaminc'] as num?)?.toDouble() ?? 0.0,
      vitaminD: (json['vitamind'] as num?)?.toDouble() ?? 0.0,
      vitaminB6: (json['vitaminb6'] as num?)?.toDouble() ?? 0.0,
      vitaminB12: (json['vitaminb12'] as num?)?.toDouble() ?? 0.0,
      vitaminE: (json['vitamine'] as num?)?.toDouble() ?? 0.0,
      vitaminK: (json['vitamink'] as num?)?.toDouble() ?? 0.0,

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

  Map<String, dynamic> toJson() {
    return {
      'meal_id': mealId,
      'name': name,
      'assigned_meal': assignedMeal,
      'meal_type_tag': mealTypeTag,
      'role': role,
      'ingredients': ingredients,
      'ingredients_text': ingredientsText,
      'tags': tags,
      'preparation_steps': preparationSteps,
      'cooking_steps': cookingSteps,
      'retrieval_vibe': retrievalVibe,
      'health_score': healthScore,
      'score_reason': scoreReason,
      'portion_scale': portionScale,
      'solver_bounds': solverBounds,

      // Final values
      'final_kcal': finalKcal,
      'final_carbs': finalCarbs,
      'final_protein': finalProtein,
      'final_totalfat': finalTotalFat,

      // Base Values
      'kcal': kcal,
      'carbs': totalCarbs,
      'sugar': sugar,
      'fiber': fiber,
      'protein': protein,
      'totalfat': totalFats,

      'saturatedfat': saturatedFat,
      'monounsaturatedfat': monounSaturatedFat,
      'polyunsaturatedfat': polyunSaturatedFat,
      'transfat': transFat,
      'cholesterol': cholesterol,

      'vitamina': vitaminA,
      'vitaminc': vitaminC,
      'vitamind': vitaminD,
      'vitaminb6': vitaminB6,
      'vitaminb12': vitaminB12,
      'vitamine': vitaminE,
      'vitamink': vitaminK,

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