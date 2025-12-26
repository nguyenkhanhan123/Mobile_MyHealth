import 'package:al_datn_my_health/view/collect_user_data/choose_weight.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/user_info.dart';

class ChooseHeight extends StatefulWidget {
  final UserInfo userInfo;
  final int? idUserInfo;
  const ChooseHeight({super.key, required this.userInfo, this.idUserInfo});

  @override
  _ChooseHeightState createState() {
    return _ChooseHeightState();
  }
}

class _ChooseHeightState extends State<ChooseHeight> {
  final TextEditingController _heightController = TextEditingController();
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
                value: 5 / 12,
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
            Image.asset('assets/images/ic_height.png',width: 165,height: 165,),
            Container(
              margin: EdgeInsets.all(25),
              child: Text(
                'Chiều cao của bạn là bao nhiêu?',
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
                margin: EdgeInsets.all(25),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 75,
                      child: TextField(
                        controller: _heightController,
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
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'cm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: "SVN_Comic",
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 40),
              child: Align(
                alignment: Alignment.center,
                child: TextButton.icon(
                  onPressed: () {
                    if (_heightController.text.trim().isNotEmpty) {
                      int? height = int.tryParse(_heightController.text);
                      if (height != null) {
                        widget.userInfo.height = height;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    ChooseWeight(userInfo: widget.userInfo,idUserInfo: widget.idUserInfo),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Vui lòng điền đúng định dạng số!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: "Vui lòng điền chiều cao của bạn!",
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
      ),
    );
  }
}
