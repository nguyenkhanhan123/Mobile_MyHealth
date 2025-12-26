import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api/sever_api.dart';
import '../../model/res/get_notification_res.dart';
import '../../model/res/update_status_res.dart';

const Color _mainGreen = Color(0xFF4CAF50);

class ItemNotification extends StatefulWidget {
  final NotificationInfo notificationInfo;
  final Function(NotificationInfo)? onTapItem;

  const ItemNotification({
    super.key,
    required this.notificationInfo,
    this.onTapItem,
  });

  @override
  State<ItemNotification> createState() => _ItemNotificationState();
}

class _ItemNotificationState extends State<ItemNotification> {
  late String _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.notificationInfo.status;
  }

  Future<void> _markAsRead() async {
    final value = await _updateStatusApi(widget.notificationInfo.id);
    if (value != null && _currentStatus == 'UNREAD') {
      setState(() {
        _currentStatus = 'READ';
      });
    }
  }

  Future<UpdateStatusRes?> _updateStatusApi(int id) async {
    final res = await SeverApi().updateStatus(id);
    if (res != null) {
      return res;
    } else {
      await Fluttertoast.showToast(
        msg: "Lỗi kết nối hoặc không tải được dữ liệu!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  String formatPublishedTime(String publishedAt) {
    final publishedDate = DateTime.tryParse(publishedAt)?.toLocal();
    if (publishedDate == null) return '';
    final now = DateTime.now();
    final diff = now.difference(publishedDate);

    if (diff.inDays >= 365) return '${(diff.inDays / 365).floor()} years ago';
    if (diff.inDays >= 30) return '${(diff.inDays / 30).floor()} months ago';
    if (diff.inDays >= 7) return '${(diff.inDays / 7).floor()} weeks ago';
    if (diff.inDays >= 1) return '${diff.inDays} days ago';
    if (diff.inHours >= 1) return '${diff.inHours} hours ago';
    if (diff.inMinutes >= 1) return '${diff.inMinutes} minutes ago';
    return 'Just now';
  }

  @override
  Widget build(BuildContext context) {
    // Dùng biến local _currentStatus thay vì widget.notificationInfo.status
    final isUnread = _currentStatus == 'UNREAD';

    final backgroundColor = isUnread ? _mainGreen.withOpacity(0.08) : Colors.white;
    final titleWeight = isUnread ? FontWeight.bold : FontWeight.w500;
    final iconBgColor = isUnread ? _mainGreen : _mainGreen.withOpacity(0.1);
    final iconColor = isUnread ? Colors.white : _mainGreen;

    return InkWell(
      onTap: () {
        // Gọi hàm đánh dấu đã đọc
        _markAsRead();

        // Hiển thị dialog
        _showDetailDialog(context);

        if (widget.onTapItem != null) {
          widget.onTapItem!(widget.notificationInfo);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 1),
            left: isUnread
                ? const BorderSide(color: _mainGreen, width: 4)
                : BorderSide.none,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_outlined,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${widget.notificationInfo.type} từ ${widget.notificationInfo.fullname}",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: titleWeight,
                      fontFamily: "SVN_Comic",
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatPublishedTime(widget.notificationInfo.createAt.toString()),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: "SVN_Comic",
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDetailDialog(BuildContext context) {
    final date = widget.notificationInfo.createAt;
    final dateStr =
        "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} "
        "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.info, color: _mainGreen),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.notificationInfo.type,
                style: const TextStyle(
                  fontFamily: "SVN_Comic",
                  fontWeight: FontWeight.bold,
                  color: _mainGreen,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black87, fontFamily: "SVN_Comic", fontSize: 14),
                  children: [
                    const TextSpan(text: "Người gửi: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "${widget.notificationInfo.fullname}\n"),
                    const TextSpan(text: "Thời gian: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: dateStr),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 8),
              const Text(
                "Nội dung:",
                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "SVN_Comic"),
              ),
              const SizedBox(height: 4),
              Text(
                widget.notificationInfo.content,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "SVN_Comic",
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(foregroundColor: _mainGreen),
            child: const Text(
              "Đóng",
              style: TextStyle(fontFamily: "SVN_Comic", fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}