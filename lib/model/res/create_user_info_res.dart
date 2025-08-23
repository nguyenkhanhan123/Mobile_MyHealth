class CreateUserInfoRes {
  final String message;
  final int idUserInfo;

  CreateUserInfoRes({required this.message,required this.idUserInfo});

  factory CreateUserInfoRes.fromJson(Map<String, dynamic> json) {
    return CreateUserInfoRes(
      message: json['message'] as String,
      idUserInfo: json['idUserInfo'] as int,
    );
  }
}
