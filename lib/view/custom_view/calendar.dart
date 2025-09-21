import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Calendar extends StatefulWidget {
  final DateTime dateTime;
  const Calendar({super.key, required this.dateTime});

  @override
  _CalendarState createState() {
    return _CalendarState();
  }
}

class _CalendarState extends State<Calendar> {
  List<String> daysOfWeek = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
  late int _currentMonth;
  late int _currentYear;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.dateTime.month;
    _currentYear = widget.dateTime.year;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (_currentMonth == 1) {
                    _currentMonth = 12;
                    _currentYear--;
                  } else {
                    _currentMonth--;
                  }
                });
              },
              icon: Icon(
                Icons.keyboard_arrow_left,
                size: 32,
                color: Colors.black,
              ),
            ),
            Text(
              "Tháng $_currentMonth",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: "SVN_Comic",
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$_currentYear",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: "SVN_Comic",
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_currentMonth == 12) {
                    _currentMonth = 1;
                    _currentYear++;
                  } else {
                    _currentMonth++;
                  }
                });
              },
              icon: Icon(
                Icons.keyboard_arrow_right,
                size: 32,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Container(color: Colors.black, height: 1),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                daysOfWeek
                    .map(
                      (day) => Expanded(
                        child: Center(
                          child: Text(
                            day,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "SVN_Comic",
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
        _buildCalendar(_daysInMonth(_currentYear,_currentMonth))
      ],
    );
  }

  List<String> _daysInMonth(int year, int month) {
    final lastDay = DateTime(year, month + 1, 0);
    List<String> list = List.generate(lastDay.day, (index) => "${index + 1}");
    int head=DateTime(year, month, 1).weekday;
    for (int i = 1; i < head; i++) {
      list.insert(0, "");
    }
    int last = (7 - (list.length % 7)) % 7;
    for (int i = 0; i < last; i++) {
      list.add("");
    }
    return list;
  }

  Widget _buildCalendar(List<String> daysInMonth) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7
      ),
      itemCount: daysInMonth.length,
      itemBuilder: (context, index) {
        final day = daysInMonth[index];

        return GestureDetector(
          onTap: day.isNotEmpty
              ? () async {
            DateTime selected = DateTime(_currentYear, _currentMonth, int.parse(day));
            DateTime today = DateTime.now();
            if (selected.isAfter(DateTime(today.year, today.month, today.day))) {
              await Fluttertoast.showToast(
                msg: "Không thể chọn ngày trong tương lai để quản lý!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            } else {
              Navigator.pop(context, selected);
            }
          }
              : null,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  color: day.isNotEmpty ? Colors.black : Colors.transparent,
                  fontSize: 16,
                  fontFamily: "SVN_Comic",
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}


