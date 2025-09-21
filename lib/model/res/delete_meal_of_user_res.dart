class DeleteMealOfUserRes {
  final String message;

  DeleteMealOfUserRes({required this.message});

  factory DeleteMealOfUserRes.fromJson(Map<String, dynamic> json) {
    return DeleteMealOfUserRes(
      message: json['message'] as String,
    );
  }
}
