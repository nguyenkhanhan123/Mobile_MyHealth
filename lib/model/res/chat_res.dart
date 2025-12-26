class ChatRes {
  final String response;

  ChatRes({required this.response});

  factory ChatRes.fromJson(Map<String, dynamic> json) {
    return ChatRes(
      response: json['response'] as String,
    );
  }
}
