class ChatReq {
  final String userId;
  final String message;
  final String threadId;

  ChatReq({
    required this.userId,
    required this.message,
    required this.threadId
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'message': message,
      'thread_id':threadId
    };
  }
}
