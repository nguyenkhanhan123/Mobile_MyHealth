class DeleteDrinkOfUserRes {
  final String message;

  DeleteDrinkOfUserRes({required this.message});

  factory DeleteDrinkOfUserRes.fromJson(Map<String, dynamic> json) {
    return DeleteDrinkOfUserRes(
      message: json['message'] as String,
    );
  }
}
