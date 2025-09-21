import 'package:flutter/material.dart';

class DeleteStatDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Xác nhận",
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontFamily: "SVN_Comic",
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Bạn chắc chắn sẽ xóa thông tin này chứ?",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: "SVN_Comic",
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            "Đồng ý",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontFamily: "SVN_Comic",
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pop(true);
          },
        ),
        TextButton(
          child: const Text(
            "Hủy",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontFamily: "SVN_Comic",
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pop(false);
          },
        )
      ],
    );
  }
}
