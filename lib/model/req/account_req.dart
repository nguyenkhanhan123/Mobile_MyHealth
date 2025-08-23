class AccountReq {
  final String userName;
  final String passWord;

  AccountReq({
    required this.userName,
    required this.passWord
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'passWord': passWord
    };
  }
}
