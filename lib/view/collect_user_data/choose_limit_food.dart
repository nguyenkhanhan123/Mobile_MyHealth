import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/limit_food.dart';
import '../../model/user_info.dart';
import 'choose_health_status.dart';

class ChooseLimitFood extends StatefulWidget {
  final UserInfo userInfo;
  const ChooseLimitFood({super.key, required this.userInfo});

  @override
  _ChooseLimitFoodState createState() {
    return _ChooseLimitFoodState();
  }
}

class _ChooseLimitFoodState extends State<ChooseLimitFood> {
  List<LimitFood> items = [
    LimitFood('', id: 1, title: 'Không có'),
    LimitFood(
      'Chế độ ăn không thịt, cá nhưng có thể ăn trứng, sữa và các sản phẩm từ sữa.',
      id: 2,
      title: 'Ăn chay',
    ),
    LimitFood(
      'Chế độ ăn hoàn toàn không có sản phẩm từ động vật như thịt, trứng, sữa, mật ong...',
      id: 3,
      title: 'Thuần chay',
    ),
    LimitFood(
      'Tránh các sản phẩm có chứa sữa như sữa bò, phô mai, bơ, sữa chua...',
      id: 4,
      title: 'Dị ứng sữa',
    ),
    LimitFood(
      'Tránh các loại hải sản như tôm, cua, cá, sò, ốc...',
      id: 5,
      title: 'Dị ứng hải sản',
    ),
    LimitFood(
      'Tránh các loại hạt như đậu phộng, hạnh nhân, hạt điều, óc chó...',
      id: 6,
      title: 'Dị ứng hạt',
    ),
    LimitFood(
      'Không sử dụng thực phẩm lên men như dưa muối, kim chi...',
      id: 7,
      title: 'Tránh thực phẩm lên men',
    ),
    LimitFood(
      'Không ăn thịt đỏ như thịt bò, thịt heo, thịt cừu...',
      id: 8,
      title: 'Không ăn thịt đỏ',
    ),
  ];

  Set<int> selectedIds = {};

  Widget buildItem(LimitFood item) {
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
            if (item.detail != '')
              IconButton(
                icon: Icon(Icons.info_outline_rounded, color: Colors.blue),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: Text(
                            item.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: "SVN_Comic",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            item.detail,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "SVN_Comic",
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                "Đồng ý",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 20,
                                  fontFamily: "SVN_Comic",
                                ),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                  );
                },
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
                value: 10 / 12,
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
          Expanded(flex: 1, child: Image.asset('assets/images/ic_limit.png')),
          Container(
            margin: EdgeInsets.all(25),
            child: Text(
              'Bạn có bất kỳ hạn chế về chế độ ăn uống, dị ứng nào không?',
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
                          widget.userInfo.limitFoodId = selectedIds.toList();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ChooseHealthStatus(
                                    userInfo: widget.userInfo,
                                  ),
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
