import 'package:al_datn_my_health/view/custom_view/calendar.dart';
import 'package:flutter/material.dart';

class StatAct extends StatefulWidget {
  final DateTime dateTime;
  const StatAct({super.key, required this.dateTime});

  @override
  _StatActState createState() => _StatActState();
}

class _StatActState extends State<StatAct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    'Lịch',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Calendar(dateTime: widget.dateTime),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
