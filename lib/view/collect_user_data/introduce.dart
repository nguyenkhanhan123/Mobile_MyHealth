import 'package:al_datn_my_health/model/user_info.dart';
import 'package:al_datn_my_health/view/collect_user_data/choose_name.dart';
import 'package:flutter/material.dart';

import '../../common_utils.dart';

class Introduce extends StatefulWidget {
  @override
  _IntroduceState createState() {
    return _IntroduceState();
  }
}

class _IntroduceState extends State<Introduce> {
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
                value: 1/12,
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
            child: Image.asset('assets/images/ic_logo_app.png'),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Chào👋 Tôi là Chuyên gia Dinh dưỡng Cá nhân của bạn được hỗ trợ bởi AI. Tôi sẽ hỏi bạn một số câu hỏi để cá nhân hóa một kế hoạch thông minh cho bạn!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: "SVN_Comic",
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 40),
            child: Align(
              alignment: Alignment.center,
              child: TextButton.icon(
                onPressed: () async {
                  final id = await CommonUtils().getPref("id");
                  UserInfo userInfo=UserInfo(accountId: int.tryParse(id.toString()));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChooseName(userInfo: userInfo)),
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
