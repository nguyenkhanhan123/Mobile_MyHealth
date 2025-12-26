import 'package:al_datn_my_health/model/res/get_user_info_res.dart';
import 'package:al_datn_my_health/model/user_info.dart';
import 'package:al_datn_my_health/view/act/login.dart';
import 'package:al_datn_my_health/view/custom_view/item_info.dart';
import 'package:al_datn_my_health/view/dialog/send_feedback_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api/sever_api.dart';
import '../../../common_utils.dart';
import '../../collect_user_data/choose_height.dart';

class SettingsFrag extends StatefulWidget {
  @override
  _SettingsFragState createState() => _SettingsFragState();
}

class _SettingsFragState extends State<SettingsFrag> {
  BasicUserInfo? basicUserInfo;
  bool isLoading = false;
  late bool hasNotification;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() {
      isLoading = true;
    });

    await _loadUserInfo();

    setState(() {
      isLoading = false;
    });
  }

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
              child: Image.asset('assets/images/ic_logo_app.png', width: 56, height: 56),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Cài đặt',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: "SVN_SAF", fontSize: 24, color: Colors.green),
                ),
              ),
            ),
          ],
        ),
        Container(height: 1, color: Colors.green),
        Expanded(
          child:
              isLoading
                  ? Center(child: CircularProgressIndicator(color: Colors.green))
                  : SingleChildScrollView(
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
                              child:
                                  basicUserInfo?.gender == "female"
                                      ? Image.asset('assets/images/ic_woman.png')
                                      : Image.asset('assets/images/ic_man.png'),
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
                                    text: basicUserInfo?.fullname ?? "Error",
                                  ),
                                  ItemInfo(
                                    icon: Icons.cake_outlined,
                                    title: "Tuổi",
                                    text: basicUserInfo?.age.toString() ?? "Error",
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    child: TextButton.icon(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green,
                                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      icon: Icon(Icons.info_outline_rounded, size: 18, color: Colors.white),
                                      label: Text(
                                        'Giới thiệu ứng dụng',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "SVN_Comic"),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => SendFeedbackDialog()
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green,
                                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      icon: Icon(Icons.comment, size: 18, color: Colors.white),
                                      label: Text(
                                        'Hòm thư góp ý',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "SVN_Comic"),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        if (basicUserInfo != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => ChooseHeight(
                                                    userInfo: UserInfo(
                                                      accountId: 0,
                                                      fullName: basicUserInfo!.fullname,
                                                      gender: basicUserInfo!.gender,
                                                      age: basicUserInfo!.age,
                                                    ),
                                                    idUserInfo: basicUserInfo!.id,
                                                  ),
                                            ),
                                          );
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green,
                                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      icon: Icon(Icons.edit_note, size: 18, color: Colors.white),
                                      label: Text(
                                        'Cập nhật thông tin',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "SVN_Comic"),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    child: TextButton.icon(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => Login()),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.green,
                                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      icon: Icon(Icons.logout, size: 18, color: Colors.white),
                                      label: Text(
                                        'Đăng xuất',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "SVN_Comic"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                        ItemInfo(
                          icon: Icons.height,
                          title: "Chiều cao",
                          text: "${basicUserInfo?.height ?? "Error"} cm",
                        ),
                        ItemInfo(
                          icon: Icons.monitor_weight,
                          title: "Cân nặng",
                          text: "${basicUserInfo?.weight ?? "Error"} kg",
                        ),
                        ItemInfo(
                          icon: Icons.accessibility_new,
                          title: "Chỉ số BMR",
                          text: "${basicUserInfo?.bmr.round() ?? "Error"} kcal",
                        ),
                        ItemInfo(
                          icon: Icons.local_fire_department,
                          title: "Chỉ số TDEE",
                          text: "${basicUserInfo?.tdee.round() ?? "Error"}  kcal",
                        ),
                        ItemInfo(
                          icon: Icons.directions_run,
                          title: "Mức độ hoạt động",
                          text: basicUserInfo?.activityLevel ?? "Error",
                        ),
                        ItemInfo(
                          icon: Icons.do_not_disturb,
                          title: "Hạn chế",
                          text: basicUserInfo?.limitFood ?? "Error",
                        ),
                        ItemInfo(
                          icon: Icons.monitor_heart,
                          title: "Tình trạng sức khỏe",
                          text: basicUserInfo?.healthStatus ?? "Error",
                        ),
                        ItemInfo(icon: Icons.restaurant_menu, title: "Chế độ ăn", text: basicUserInfo?.diet ?? "Error"),
                      ],
                    ),
                  ),
        ),
      ],
    );
  }

  Future<void> _loadUserInfo() async {
    final idUserInfo = await CommonUtils().getPref("idUserInfo");
    final result = int.tryParse(idUserInfo.toString());

    if (result != null) {
      final value = await _getUserInfo(result);
      if (value != null) {
        setState(() {
          basicUserInfo = value;
        });
      } else {
        setState(() {
          basicUserInfo = null;
        });
      }
    }
  }

  Future<BasicUserInfo?> _getUserInfo(int userId) async {
    final res = await SeverApi().getUserInfoById(userId);
    if (res != null && res.message == "Find successful") {
      return res.userInfo;
    } else {
      await Fluttertoast.showToast(
        msg: "Kết nối không ổn định!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }
}
