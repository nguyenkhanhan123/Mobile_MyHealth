class GetUserInfoRes {
  final String message;
  final BasicUserInfo userInfo;

  GetUserInfoRes({
    required this.message,
    required this.userInfo,
  });

  factory GetUserInfoRes.fromJson(Map<String, dynamic> json) {
    return GetUserInfoRes(
      message: json['message'] as String,
      userInfo: BasicUserInfo.fromJson(json['userInfo']),
    );
  }
}

class BasicUserInfo {
  final int id;
  final String fullname;
  final String gender;
  final int age;
  final int height;
  final double weight;
  final String activityLevel;
  final String limitFood;
  final String healthStatus;
  final String diet;
  final double bmr;
  final double tdee;

  BasicUserInfo({
    required this.id,
    required this.fullname,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.limitFood,
    required this.healthStatus,
    required this.diet,
    required this.bmr,
    required this.tdee,
  });

  factory BasicUserInfo.fromJson(Map<String, dynamic> json) {
    return BasicUserInfo(
      id: json['id'] as int,
      fullname: json['fullname'] as String,
      gender: json['gender'] as String,
      age: json['age'] as int,
      height: json['height'] as int,
      weight: (json['weight'] as num).toDouble(),
      activityLevel: json['activityLevel'] as String,
      limitFood: json['limitFood'] as String,
      healthStatus: json['healthStatus'] as String,
      diet: json['diet'] as String,
      bmr: (json['bmr'] as num).toDouble(),
      tdee: (json['tdee'] as num).toDouble(),
    );
  }
}
