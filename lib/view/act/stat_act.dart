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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Thống kê',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "SVN_SAF",
                    fontSize: 24,
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Calendar(dateTime: widget.dateTime),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
