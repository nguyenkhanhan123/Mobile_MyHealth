class AddNotificationRes {
  final String message;

  AddNotificationRes({required this.message});

  factory AddNotificationRes.fromJson(Map<String, dynamic> json) {
    return AddNotificationRes(
      message: json['message'] as String,
    );
  }
}
