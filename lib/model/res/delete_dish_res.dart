class DeleteDishRes {
  final String message;

  DeleteDishRes({required this.message});

  factory DeleteDishRes.fromJson(Map<String, dynamic> json) {
    return DeleteDishRes(
      message: json['message'] as String,
    );
  }
}
