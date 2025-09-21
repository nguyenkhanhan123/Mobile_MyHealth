import 'package:al_datn_my_health/view/act/admin/main_act_admin.dart';
import 'package:al_datn_my_health/view/collect_user_data/introduce.dart';
import 'package:al_datn_my_health/view/act/login.dart';
import 'package:al_datn_my_health/view/act/client/main_act.dart';
import 'package:al_datn_my_health/view/act/register.dart';
import 'package:flutter/material.dart';

class SplashAct extends StatefulWidget {
  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashAct> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_logo_app.png',width: 215,height: 215),
          ],
        ),
      ),
    );
  }
}
