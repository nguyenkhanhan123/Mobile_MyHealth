import 'package:al_datn_my_health/view/collect_user_data/choose_height.dart';
import 'package:al_datn_my_health/view/collect_user_data/choose_limit_food.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../model/user_info.dart';

class ChooseCompleteTarget extends StatefulWidget {
  final UserInfo userInfo;
  const ChooseCompleteTarget({super.key, required this.userInfo});
  @override
  _ChooseCompleteTargetState createState() {
    return _ChooseCompleteTargetState();
  }
}

class _ChooseCompleteTargetState extends State<ChooseCompleteTarget> {
  int _currentDateValue = 1;
  int _currentMonthValue = 1;
  int _currentYearValue = 2025;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                color: Color.fromARGB(255, 57, 206, 41),
                backgroundColor: Color.fromARGB(255, 215, 236, 255),
                value: 9 / 12,
                minHeight: 6,
                borderRadius: BorderRadius.all(Radius.circular(90)),
              ),
              SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "My",
                      style: TextStyle(
                        fontFamily: "SVN_Ready",
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Health",
                      style: TextStyle(
                        fontFamily: "SVN_Ready",
                        fontSize: 32,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Image.asset('assets/images/ic_calender_target.png'),
          ),
          Container(
            margin: EdgeInsets.all(25),
            child: Text(
              'Bạn muốn mình hoàn thành mục tiêu đề ra vào ngày nào?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontFamily: "SVN_Comic",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Ngày',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: "SVN_Comic",
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Tháng',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: "SVN_Comic",
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Năm',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: "SVN_Comic",
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 150,
                  child: NumberPicker(
                    value: _currentDateValue,
                    minValue: 1,
                    maxValue: 31,
                    step: 1,
                    itemHeight: 50,
                    itemCount: 3,
                    axis: Axis.vertical,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blueAccent, width: 2),
                    ),
                    selectedTextStyle: const TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    onChanged:
                        (value) => setState(() => _currentDateValue = value),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 150,
                  child: NumberPicker(
                    value: _currentMonthValue,
                    minValue: 1,
                    maxValue: 12,
                    step: 1,
                    itemHeight: 50,
                    itemCount: 3,
                    axis: Axis.vertical,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blueAccent, width: 2),
                    ),
                    selectedTextStyle: const TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    onChanged:
                        (value) => setState(() => _currentMonthValue = value),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 150,
                  child: NumberPicker(
                    value: _currentYearValue,
                    minValue: 2025,
                    maxValue: 2035,
                    step: 1,
                    itemHeight: 50,
                    itemCount: 3,
                    axis: Axis.vertical,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blueAccent, width: 2),
                    ),
                    selectedTextStyle: const TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    onChanged:
                        (value) => setState(() => _currentYearValue = value),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 40),
            child: Align(
              alignment: Alignment.center,
              child: TextButton.icon(
                onPressed: () {
                  if (isValidDate(_currentYearValue, _currentMonthValue, _currentDateValue)) {
                    DateTime dateTime = DateTime(_currentYearValue, _currentMonthValue, _currentDateValue);
                    widget.userInfo.dateTarget=dateTime;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChooseLimitFood(userInfo: widget.userInfo)),
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "Ngày, Tháng, Năm không phù hợp!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black87,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                icon: Icon(
                  Icons.subdirectory_arrow_right_outlined,
                  size: 24,
                  color: Colors.white,
                ),
                label: Text(
                  'Tiếp tục',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: "SVN_Comic",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isValidDate(int year, int month, int day) {
    try {
      DateTime d = DateTime(year, month, day);
      return d.year == year && d.month == month && d.day == day;
    } catch (e) {
      return false;
    }
  }

}
