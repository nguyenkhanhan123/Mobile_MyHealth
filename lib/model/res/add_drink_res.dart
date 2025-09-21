class AddDrinkRes {
  final String message;

  AddDrinkRes({required this.message});

  factory AddDrinkRes.fromJson(Map<String, dynamic> json) {
    return AddDrinkRes(
      message: json['message'] as String,
    );
  }
}
