class UpdateUserinfoRes {
  final String message;

  UpdateUserinfoRes({required this.message});

  factory UpdateUserinfoRes.fromJson(Map<String, dynamic> json) {
    return UpdateUserinfoRes(
      message: json['message'] as String,
    );
  }
}
