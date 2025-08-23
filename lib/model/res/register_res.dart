class RegisterRes {
  final String message;
  final int accountId;

  RegisterRes({required this.message,required this.accountId});

  factory RegisterRes.fromJson(Map<String, dynamic> json) {
    return RegisterRes(
      message: json['message'] as String,
      accountId: json['accountId'] as int,
    );
  }
}
