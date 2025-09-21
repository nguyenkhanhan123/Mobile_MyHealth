class ListFoodRes {
  final String message;
  final List<InfoFood> similar;

  ListFoodRes({required this.message,required this.similar});

  factory ListFoodRes.fromJson(Map<String, dynamic> json) {
    return ListFoodRes(
      message: json['message'] as String,
      similar: (json['similar'] as List<dynamic>)
          .map((item) => InfoFood.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class InfoFood {
  final int id;
  final String name;
  final String thumbnail;
  final int kcal;
  final String baseUnit;
  final int isConfirm;


  InfoFood({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.kcal,
    required this.baseUnit,
    required this.isConfirm,
  });

  factory InfoFood.fromJson(Map<String, dynamic> json) {
    return InfoFood(
      id: json['id'] as int,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      kcal: json['kcal'] as int,
      baseUnit: json['baseUnit'] as String,
      isConfirm: json['isConfirm'] as int,
    );
  }
}
