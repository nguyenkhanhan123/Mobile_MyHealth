import 'dart:async';

import 'package:al_datn_my_health/model/res/list_exercise_res.dart';
import 'package:al_datn_my_health/view/custom_view/item_exercise.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api/sever_api.dart';

class ChooseExerciseAct extends StatefulWidget {
  final DateTime selectedDate;

  const ChooseExerciseAct({super.key, required this.selectedDate});
  @override
  _ChooseExerciseActState createState() => _ChooseExerciseActState();
}

class _ChooseExerciseActState extends State<ChooseExerciseAct> {
  List<InfoExercise> infoExercise = [];
  @override
  void initState() {
    super.initState();
    _findExercise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Chọn bài tập',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "SVN_SAF",
                        fontSize: 24,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 1, color: Colors.green),
            Expanded(
              child: ListView.builder(
                itemCount: infoExercise.length,
                itemBuilder: (context, index) {
                  return ItemExercise(infoExercise: infoExercise[index],selectedDate: widget.selectedDate,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _findExercise() async {
    final res = await SeverApi().findExercise();
    if (res != null && res.message == "Find successful") {
      setState(() {
        infoExercise = res.exercises;
      });
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
