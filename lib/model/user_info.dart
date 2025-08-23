class UserInfo {
  String? fullName;
  String? gender;
  int? age;
  int? height;
  int? weight;
  int? weightTarget;
  DateTime? dateTarget;
  int? accountId;
  int? activityLevelId;
  int? dietId;
  List<int>? limitFoodId;
  List<int>? healthStatusId;

  UserInfo({
    this.fullName,
    this.gender,
    this.age,
    this.height,
    this.weight,
    this.weightTarget,
    this.dateTarget,
    this.accountId,
    this.activityLevelId,
    this.dietId,
    this.limitFoodId,
    this.healthStatusId,
  });

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "gender": gender,
      "age": age,
      "height": height,
      "weight": weight,
      "weightTarget": weightTarget,
      "dateTarget": dateTarget?.toIso8601String().split('T').first,
      "Accountid": accountId,
      "ActivityLevelid": activityLevelId,
      "Dietid": dietId,
      "LimitFoodid": limitFoodId,
      "HealthStatusid": healthStatusId,
    };
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      fullName: json["fullName"],
      gender: json["gender"],
      age: json["age"],
      height: json["height"],
      weight: json["weight"],
      weightTarget: json["weightTarget"],
      dateTarget: json["dateTarget"] != null ? DateTime.parse(json["dateTarget"]) : null,
      accountId: json["Accountid"],
      activityLevelId: json["ActivityLevelid"],
      dietId: json["Dietid"],
      limitFoodId: json["LimitFoodid"] != null ? List<int>.from(json["LimitFoodid"]) : null,
      healthStatusId: json["HealthStatusid"] != null ? List<int>.from(json["HealthStatusid"]) : null,
    );
  }
}
