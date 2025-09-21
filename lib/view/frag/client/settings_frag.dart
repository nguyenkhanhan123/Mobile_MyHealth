import 'package:al_datn_my_health/view/custom_view/item_info.dart';
import 'package:flutter/material.dart';

class SettingsFrag extends StatefulWidget {
  @override
  _SettingsFragState createState() => _SettingsFragState();
}

class _SettingsFragState extends State<SettingsFrag> {
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
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'Cài đặt',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "SVN_SAF",
                  fontSize: 24,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
        Container(height: 1, color: Colors.green),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset('assets/images/ic_man.png'),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ItemInfo(
                            icon: Icons.text_fields,
                            title: "Tên",
                            text: "Nguyễn Khánh An",
                          ),
                          ItemInfo(
                            icon: Icons.cake_outlined,
                            title: "Tuổi",
                            text: "22",
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: TextButton.icon(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 6,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: Icon(
                                Icons.translate,
                                size: 18,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Chuyển sang tiếng Anh',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "SVN_Comic",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: TextButton.icon(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 6,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: Icon(
                                Icons.delete,
                                size: 18,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Xóa dữ liệu của bạn',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "SVN_Comic",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: TextButton.icon(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 6,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: Icon(
                                Icons.logout,
                                size: 18,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Đăng xuất',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "SVN_Comic",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Text(
                        "Hồ sơ thể chất",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: "SVN_Comic",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                      child: TextButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                          backgroundColor: Color.fromARGB(255, 215, 236, 255),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        icon: Icon(Icons.autorenew, size: 16),
                        label: Text(
                          "Cập nhật",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "SVN_Comic",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ItemInfo(
                  icon: Icons.height,
                  title: "Chiều cao",
                  text: "170 cm",
                ),
                ItemInfo(
                  icon: Icons.monitor_weight,
                  title: "Cân nặng",
                  text: "58 kg",
                ),
                ItemInfo(
                  icon: Icons.directions_run,
                  title: "Mức độ hoạt động",
                  text: "Ít vận động",
                ),
                ItemInfo(
                  icon: Icons.do_not_disturb,
                  title: "Hạn chế",
                  text: "Không có",
                ),
                ItemInfo(
                  icon: Icons.monitor_heart,
                  title: "Tình trạng sức khỏe",
                  text: "Viêm loét, trào ngược dạ dày",
                ),
                ItemInfo(
                  icon: Icons.restaurant_menu,
                  title: "Chế độ ăn",
                  text: "Chế độ ăn cân bằng",
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
