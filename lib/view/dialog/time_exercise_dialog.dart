import 'package:al_datn_my_health/model/req/add_exercise_req.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api/sever_api.dart';
import '../../common_utils.dart';
import '../../model/res/list_exercise_res.dart';

class TimeExerciseDialog extends StatefulWidget {
  final InfoExercise infoExercise;
  final DateTime selectedDate;
  const TimeExerciseDialog({super.key, required this.infoExercise, required this.selectedDate});

  @override
  _TimeExerciseDialogState createState() => _TimeExerciseDialogState();
}

class _TimeExerciseDialogState extends State<TimeExerciseDialog> {
  String? selectedValue;
  List<String> items = ["Thấp", "Vừa phải", "Cao", "Rất cao"];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedValue = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.infoExercise.nameExercise,
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontFamily: "SVN_Comic",
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.infoExercise.detail.replaceAll(r'\n', '\n'),
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontFamily: "SVN_Comic",
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "Mức độ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "SVN_Comic",
                    ),
                  ),
                  SizedBox(height: 8),
                  DropdownButton<String>(
                    value: selectedValue,
                    items:
                        items.map((str) {
                          return DropdownMenuItem<String>(
                            value: str,
                            child: Text(
                              str,
                              style: TextStyle(
                                fontFamily: "SVN_Comic",
                                fontSize: 16,
                              ),
                            ),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(width: 8),
              Column(
                children: [
                  Text(
                    "Thời gian",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "SVN_Comic",
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: 65,
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.green,
                          textAlign: TextAlign.center,
                          maxLength: 3,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 3,
                              ),
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
                        "phút",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "SVN_Comic",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
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
          onPressed: () async {
            final idUserInfo = await CommonUtils().getPref("idUserInfo");
            final result = int.tryParse(idUserInfo.toString());

            int? value = int.tryParse(_controller.text.trim());

            final formattedDate =
                "${widget.selectedDate.year}-${widget.selectedDate.month.toString().padLeft(2, '0')}-${widget.selectedDate.day.toString().padLeft(2, '0')}";
            if (value != null && selectedValue != null && result != null) {
              final sucess = await _addExercise(
                result,
                widget.infoExercise.id,
                value,
                selectedValue!,
                formattedDate
              );
              if (sucess) {
                Navigator.pop(context, true);
              }
            }
          },
        ),
      ],
    );
  }

  Future<bool> _addExercise(
    int userId,
    int exerciseId,
    int time,
    String levelExercise, String date,
  ) async {
    final req = AddExerciseReq(
      userId: userId,
      exerciseId: exerciseId,
      levelExercise: levelExercise,
      time: time,
      date: date
    );
    final res = await SeverApi().addExercise(req);
    if (res != null && res.message == "Create exercise successful") {
      await Fluttertoast.showToast(
        msg: "Thêm nước uống thành công!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    } else {
      await Fluttertoast.showToast(
        msg: "Chưa thể thêm nước uống hoặc kết nối không ổn định!",
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
