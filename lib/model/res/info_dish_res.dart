import 'package:al_datn_my_health/model/hashtag.dart';

class InfoDishRes {
  final String message;
  final Dish dish;

  InfoDishRes({
    required this.message,
    required this.dish,
  });

  factory InfoDishRes.fromJson(Map<String, dynamic> json) {
    return InfoDishRes(
      message: json['message'] as String,
      dish: Dish.fromJson(json['dish']),
    );
  }
}

class Dish {
  final int id;
  final String name;
  final String thumbnail;
  final int isConfirm;
  final String description;
  final String preparationSteps;
  final String cookingSteps;
  final List<BasicIngredient> ingredients;
  final List<Hashtag> hashtags;

  Dish({
    required this.id,
    required this.name,
    required this.isConfirm,
    required this.thumbnail,
    required this.cookingSteps,
    required this.preparationSteps,
    required this.description,
    required this.ingredients,
    required this.hashtags,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'] as int,
      name: json['name'] as String,
      isConfirm: json['isConfirm'] as int,
      thumbnail: json['thumbnail'] as String,
      cookingSteps: json['cookingSteps'] as String,
      preparationSteps: json['preparationSteps'] as String,
      description: json['description'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => BasicIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      hashtags: (json['hashtags'] as List<dynamic>)
          .map((e) => Hashtag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class BasicIngredient {
  final int ingredientId;
  final String name;
  final double weight;
  final String unit;
  final String thumbnail;

  BasicIngredient({
    required this.ingredientId,
    required this.name,
    required this.weight,
    required this.unit,
    required this.thumbnail,
  });

  factory BasicIngredient.fromJson(Map<String, dynamic> json) {
    return BasicIngredient(
      ingredientId: json['ingredientId'] as int,
      name: json['name'] as String,
      weight: (json['weight'] as num).toDouble(),
      unit: json['unit'] as String,
      thumbnail: json['thumbnail'] as String,
    );
  }
}
