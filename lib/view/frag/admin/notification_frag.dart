import 'package:al_datn_my_health/api/sever_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../model/res/get_notification_res.dart';
import '../../act/login.dart';
import '../../custom_view/item_notification.dart';

class NotificationFrag extends StatefulWidget {
  @override
  _NotificationFragState createState() => _NotificationFragState();
}

class _NotificationFragState extends State<NotificationFrag> {
  GetNotificationsRes? getNotificationsRes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() {
      isLoading = true;
    });

    await _loadNotifications();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Image.asset(
                'assets/images/ic_logo_app.png',
                width: 56,
                height: 56,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Thông báo',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "SVN_SAF",
                    fontSize: 24,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                icon: Icon(Icons.logout, color: Colors.green, size: 32),
              ),
            ),
          ],
        ),
        Container(height: 1, color: Colors.green),
        Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.green))
              : SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getNotificationsRes == null ||
                    getNotificationsRes!.notifications.isEmpty
                    ? Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    "Không có thông báo nào",
                    style: TextStyle(
                      fontFamily: "SVN_Comic",
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                )
                    : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...getNotificationsRes!.notifications.map((notification) {
                      return ItemNotification(
                        notificationInfo: notification,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _loadNotifications() async {
      final value = await _getNotificationsApi(0);
      if (value != null) {
        setState(() {
          getNotificationsRes = value;
        });
      } else {
        setState(() {
          getNotificationsRes = null;
        });
      }
  }

  Future<GetNotificationsRes?> _getNotificationsApi(int userId) async {
    final res = await SeverApi().getNotificationsBySenderId(userId);
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
}