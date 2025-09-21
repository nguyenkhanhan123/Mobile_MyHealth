import 'package:flutter/material.dart';

class WeightDishDialog extends StatefulWidget {
  const WeightDishDialog({super.key});

  @override
  _WeightDishDialogState createState() => _WeightDishDialogState();
}

class _WeightDishDialogState extends State<WeightDishDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Khối lượng món ăn",
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontFamily: "SVN_Comic",
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Row(
        children: [
          SizedBox(
            width: 65,
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              cursorColor: Colors.green,
              textAlign: TextAlign.center,
              maxLength: 5,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 3),
                ),
                counterText: "",
              ),
              style: TextStyle(
                color: Colors.black,
                fontFamily: "SVN_Comic",
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(width: 4),
          Text(
            "g",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: "SVN_Comic",
            ),
          ),
        ],
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
          onPressed: () {
            double? value = double.tryParse(_controller.text.trim()) ?? 0;
            Navigator.of(context).pop(value);
          },
        ),
      ],
    );
  }
}
