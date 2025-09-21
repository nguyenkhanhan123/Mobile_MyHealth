class AddDishRes {
  final String message;

  AddDishRes({required this.message});

  factory AddDishRes.fromJson(Map<String, dynamic> json) {
    return AddDishRes(
      message: json['message'] as String,
    );
  }
}
