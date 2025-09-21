class UpdateDishRes {
  final String message;

  UpdateDishRes({required this.message});

  factory UpdateDishRes.fromJson(Map<String, dynamic> json) {
    return UpdateDishRes(
      message: json['message'] as String,
    );
  }
}
