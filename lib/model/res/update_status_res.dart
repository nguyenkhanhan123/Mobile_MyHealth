class UpdateStatusRes {
  final String message;

  UpdateStatusRes({required this.message});

  factory UpdateStatusRes.fromJson(Map<String, dynamic> json) {
    return UpdateStatusRes(
      message: json['message'] as String,
    );
  }
}
