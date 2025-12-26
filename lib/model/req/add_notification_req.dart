class AddNotificationReq {
  final int senderId;
  final int receiverId;
  final int relatedId;
  final String type;
  final String content;

  AddNotificationReq({
    required this.senderId,
    required this.receiverId,
    required this.relatedId,
    required this.type,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'relatedId': relatedId,
      'type': type,
      'content': content,
    };
  }
}
