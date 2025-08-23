import 'package:al_datn_my_health/model/health_status.dart';
import 'package:al_datn_my_health/view/collect_user_data/choose_food_mode.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/user_info.dart';

class ChooseHealthStatus extends StatefulWidget {
  final UserInfo userInfo;
  const ChooseHealthStatus({super.key, required this.userInfo});

  @override
  _ChooseHealthStatusState createState() {
    return _ChooseHealthStatusState();
  }
}

class _ChooseHealthStatusState extends State<ChooseHealthStatus> {
  List<HealthStatus> items = [
    HealthStatus(id: 1, title: 'Không có'),
    HealthStatus(id: 2, title: 'Suy thận, Sỏi thận'),
    HealthStatus(id: 3, title: 'Xơ gan, Viêm gan'),
    HealthStatus(id: 4, title: 'Gout'),
    HealthStatus(id: 5, title: 'Suy dinh dưỡng'),
    HealthStatus(id: 6, title: 'Bỏng nặng'),
    HealthStatus(id: 7, title: 'Thiếu máu'),
    HealthStatus(id: 8, title: 'Bệnh tim mạch'),
    HealthStatus(id: 9, title: 'Tiểu đường'),
    HealthStatus(id: 10, title: 'Loãng xương'),
    HealthStatus(id: 11, title: 'Phụ nữ mang thai'),
    HealthStatus(id: 12, title: 'Viêm loét, trào ngược dạ dày'),
  ];

  Set<int> selectedIds = {};

  Widget buildItem(HealthStatus item) {
    bool isSelected = selectedIds.contains(item.id);

    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedIds.remove(item.id);
          } else {
            selectedIds.add(item.id);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    if (item.id == 1) {
                      selectedIds.clear();
                      selectedIds.add(1);
                    } else {
                      selectedIds.remove(1);
                      selectedIds.add(item.id);
                    }
                  } else {
                    selectedIds.remove(item.id);
                  }
                });
              },
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: "SVN_Comic",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                value: 11 / 12,
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
          Expanded(flex: 1, child: Image.asset('assets/images/ic_doctor.png')),
          Container(
            margin: EdgeInsets.all(25),
            child: Text(
              'Bạn có đang bị bệnh nào không?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontFamily: "SVN_Comic",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView(
              children: items.map((item) => buildItem(item)).toList(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 40),
            child: Align(
              alignment: Alignment.center,
              child: TextButton.icon(
                onPressed:
                    selectedIds.isEmpty
                        ? () {
                          Fluttertoast.showToast(
                            msg: "Vui lòng chọn 1 mục!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.black87,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                        : () {
                          widget.userInfo.healthStatusId = selectedIds.toList();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      ChooseFoodMode(userInfo: widget.userInfo),
                            ),
                          );
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
}
