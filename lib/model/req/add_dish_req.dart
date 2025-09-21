class AddDishReq {
  final String name;
  final String? thumbnail;
  final int isConfirm;
  final String? description;
  final String? preparationSteps;
  final String? cookingSteps;
  final List<IngredientItem> ingredients;
  final List<int> hashtagId;

  AddDishReq({
    required this.name,
    this.thumbnail,
    this.isConfirm = 0,
    this.description,
    this.preparationSteps,
    this.cookingSteps,
    required this.ingredients,
    required this.hashtagId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'thumbnail': thumbnail,
      'isConfirm': isConfirm,
      'description': description,
      'preparationSteps': preparationSteps,
      'cookingSteps': cookingSteps,
      'ingredients': ingredients.map((e) => e.toMap()).toList(),
      'hashtagId': hashtagId,
    };
  }
}

class IngredientItem {
  final int ingredientId;
  final double weight;

  IngredientItem({required this.ingredientId, required this.weight});

  Map<String, dynamic> toMap() {
    return {
      'ingredientId': ingredientId,
      'weight': weight,
    };
  }
}
