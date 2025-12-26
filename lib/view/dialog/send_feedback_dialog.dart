import 'package:al_datn_my_health/model/req/add_notification_req.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api/sever_api.dart';
import '../../common_utils.dart';

class SendFeedbackDialog extends StatefulWidget {
  @override
  _SendFeedbackDialogState createState() => _SendFeedbackDialogState();
}

class _SendFeedbackDialogState extends State<SendFeedbackDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Hòm thư góp ý",
        style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: "SVN_Comic", fontWeight: FontWeight.bold),
      ),
      content: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.green, width: 1.5),
        ),
        child: Padding(
            padding: EdgeInsets.all(3),
            child: TextField(
              controller: _controller,
              cursorColor: Colors.black,
              maxLines: 5,
              decoration: InputDecoration(
                hintText:
                    'Hãy viết những nhận xét, cảm nhận của bạn về ứng dụng để chúng tôi cải thiện trong tương lai!',
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      actions: [
        TextButton(
          child: const Text("Gửi", style: TextStyle(color: Colors.blueAccent, fontSize: 20, fontFamily: "SVN_Comic")),
          onPressed: () async {
            final idUserInfo = await CommonUtils().getPref("idUserInfo");
            final result = int.tryParse(idUserInfo.toString());
            final content=_controller.text;
            if (content != "" && result != null) {
              final sucess = await _addNotification(result,content);
              if (sucess) {
                Navigator.pop(context, true);
              }
            }
          },
        ),
      ],
    );
  }

  Future<bool> _addNotification(int senderId, String content) async {
    final req = AddNotificationReq(senderId: senderId, receiverId: 0, type: "FEEDBACK", relatedId: 0, content: content);
    final res = await SeverApi().addNotification(req);
    if (res != null && res.message == "Create notification successful") {
      await Fluttertoast.showToast(
        msg: "Gửi góp ý thành công!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    } else {
      await Fluttertoast.showToast(
        msg: "Chưa thể gửi hoặc kết nối không ổn định!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }
}
