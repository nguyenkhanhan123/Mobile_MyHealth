class GetNotificationsRes {
  final String message;
  final List<NotificationInfo> notifications;

  GetNotificationsRes({
    required this.message,
    required this.notifications,
  });

  factory GetNotificationsRes.fromJson(Map<String, dynamic> json) {
    return GetNotificationsRes(
      message: json['message'],
      notifications: (json['notifications'] as List)
          .map((e) => NotificationInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class NotificationInfo {
  final int id;
  final String fullname;
  final String type;
  final String content;
  final DateTime createAt;
  final String status;

  NotificationInfo({
    required this.id,
    required this.fullname,
    required this.type,
    required this.content,
    required this.createAt,
    required this.status,
  });

  factory NotificationInfo.fromJson(Map<String, dynamic> json) {
    return NotificationInfo(
      id: json['id'] as int,
      fullname: json['fullname'] as String,
      type: json['type'] as String,
      content: json['content'] as String,
      createAt: DateTime.parse(json['createAt'].toString()),
      status: json['status'] as String,
    );
  }
}