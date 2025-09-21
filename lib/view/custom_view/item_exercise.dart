import 'package:al_datn_my_health/model/res/list_exercise_res.dart';
import 'package:al_datn_my_health/view/dialog/time_exercise_dialog.dart';
import 'package:flutter/material.dart';

class ItemExercise extends StatelessWidget {
  final InfoExercise infoExercise;

  final DateTime selectedDate;

  const ItemExercise({super.key, required this.infoExercise, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, color: Colors.green),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    infoExercise.thumbnail,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Image.asset(
                          'assets/images/ic_exercise3.png',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  infoExercise.nameExercise,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "SVN_Comic",
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final isAdd = await showDialog<bool>(
                    context: context,
                    builder: (context) => TimeExerciseDialog(infoExercise: infoExercise,selectedDate: selectedDate,),
                  );
                  if(isAdd==true) {
                    Navigator.pop(context, true);
                  }
                },
                icon: Icon(Icons.add, size: 28, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
