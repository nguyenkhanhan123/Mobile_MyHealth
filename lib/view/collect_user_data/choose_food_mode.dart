import 'package:al_datn_my_health/model/food_mode.dart';
import 'package:al_datn_my_health/view/act/client/main_act.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api/sever_api.dart';
import '../../common_utils.dart';
import '../../model/user_info.dart';

class ChooseFoodMode extends StatefulWidget {
  final UserInfo userInfo;
  final int? idUserInfo;
  const ChooseFoodMode({super.key, required this.userInfo, this.idUserInfo});

  @override
  _ChooseFoodModeState createState() {
    return _ChooseFoodModeState();
  }
}

class _ChooseFoodModeState extends State<ChooseFoodMode> {
  List<FoodMode> items = [
    FoodMode(
      'Chế độ ăn cân bằng bao gồm đầy đủ các nhóm dưỡng chất: protein, chất béo, tinh bột, vitamin và khoáng chất với tỉ lệ hợp lý.',
      id: 1,
      title: 'Chế độ ăn cân bằng',
    ),
    FoodMode(
      'Chế độ ăn Địa Trung Hải tập trung vào rau củ, trái cây, ngũ cốc nguyên cám, cá, dầu ô liu và hạn chế thịt đỏ, thực phẩm chế biến sẵn.',
      id: 2,
      title: 'Chế độ ăn Địa Trung Hải',
    ),
    FoodMode(
      'Chế độ LowCarb giảm thiểu lượng carbohydrate, tăng protein và chất béo lành mạnh, hỗ trợ giảm cân và kiểm soát đường huyết.',
      id: 3,
      title: 'Chế độ LowCarb',
    ),
    FoodMode(
      'Chế độ Keto cực kỳ thấp carb, cao chất béo và vừa phải protein, giúp cơ thể chuyển sang trạng thái ketosis để đốt mỡ thay vì glucose.',
      id: 4,
      title: 'Chế độ Keto',
    ),
    FoodMode(
      'Chế độ HighProtein tăng cường lượng protein từ thịt nạc, trứng, sữa và các loại đậu nhằm hỗ trợ tăng cơ, giảm mỡ.',
      id: 5,
      title: 'Chế độ HighProtein',
    ),
    FoodMode(
      'Chế độ Paleo bắt chước cách ăn của tổ tiên thời săn bắt, gồm thịt, cá, rau củ, trái cây, tránh thực phẩm chế biến và ngũ cốc tinh luyện.',
      id: 6,
      title: 'Chế độ Paleo',
    ),
  ];

  int? selectedId;

  Widget buildItem(FoodMode item) {
    return RadioListTile<int>(
      value: item.id,
      groupValue: selectedId,
      onChanged:
          (!widget.userInfo.healthStatusId!.contains(1) && item.id != 1)
              ? null
              : (value) {
                setState(() {
                  selectedId = value;
                });
              },
      title: Text(
        item.title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontFamily: "SVN_Comic",
        ),
      ),
      secondary:
          item.detail.isNotEmpty
              ? IconButton(
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
              )
              : null,
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
                value: 12 / 12,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ic_food_mode.png',
              width: 145,
              height: 145,
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                'Bạn thích chế độ ăn uống nào?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: "SVN_Comic",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Text(
                'Nếu bạn có tình trạng sức khỏe, sẽ chỉ được áp dụng chế độ ăn cân bằng!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: "SVN_Comic",
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: items.map((item) => buildItem(item)).toList(),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 40),
              child: Align(
                alignment: Alignment.center,
                child: TextButton.icon(
                  onPressed: () {
                    if (selectedId == null) {
                      Fluttertoast.showToast(
                        msg: "Vui lòng chọn 1 chế độ ăn!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      return;
                    }
                    widget.userInfo.dietId = selectedId;
                    if(widget.idUserInfo==null) {
                      _createUserInfo(widget.userInfo);
                    }
                    else{
                      _updateUserInfo(widget.userInfo,widget.idUserInfo!);
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
                    Icons.verified_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Hoàn thành',
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
      ),
    );
  }

  Future<void> _createUserInfo(UserInfo userInfo) async {
    final res = await SeverApi().createUserInfo(userInfo);
    if (res != null && res.message == "User info created successfully") {
      CommonUtils().savePref("idUserInfo", res.idUserInfo.toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainAct()),
      );
    } else {
      await Fluttertoast.showToast(
        msg: "Kết nối không ổn định!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _updateUserInfo(UserInfo userInfo, int id) async {
    final res = await SeverApi().updateUserInfo(userInfo,id);
    if (res != null && res.message == "Update userinfo successful") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainAct()),
      );
    } else {
      await Fluttertoast.showToast(
        msg: "Kết nối không ổn định!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
