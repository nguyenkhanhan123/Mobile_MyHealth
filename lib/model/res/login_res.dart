class LoginRes {
  final String message;
  final Account? account;
  final int? idUserInfo;

  LoginRes({this.idUserInfo, required this.message, this.account});

  factory LoginRes.fromJson(Map<String, dynamic> json) {
    return LoginRes(
      message: json['message'] as String,
      account: json['account'] != null
          ? Account.fromJson(json['account'])
          : null,
      idUserInfo: json['idUserInfo'] as int?,
    );
  }
}

class Account {
  final int id;
  final String userName;
  final int isCollectionInfo;

  Account({
    required this.id,
    required this.userName,
    required this.isCollectionInfo,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as int,
      userName: json['userName'] as String,
      isCollectionInfo: json['isCollectionInfo'] as int,
    );
  }
}
