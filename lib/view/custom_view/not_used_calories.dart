import 'package:flutter/material.dart';

class NotUsedCalories extends StatelessWidget {
  final double target;
  final double exercise;
  final double food;

  const NotUsedCalories({super.key, required this.target, required this.exercise, required this.food});

  @override
  Widget build(BuildContext context) {
    final int formattedFood=food.round();
    final int formattedTarget=target.round();
    final int formattedExercise=exercise.round();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 4,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formattedTarget.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "SVN_Comic",
                ),
              ),
              Text(
                "Mục tiêu",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "SVN_Comic",
                ),
              ),
            ],
          ),
          Icon(
            Icons.add,
            color: Colors.black,
            size: 16,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formattedExercise.toString(),
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontFamily: "SVN_Comic",
                ),
              ),
              Text(
                "Tập thể dục",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontFamily: "SVN_Comic",
                ),
              ),
            ],
          ),
          Icon(
              Icons.remove,
              color: Colors.black,
              size: 16
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formattedFood.toString(),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontFamily: "SVN_Comic",
                ),
              ),
              Text(
                "Thực phẩm",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontFamily: "SVN_Comic",
                ),
              ),
            ],
          ),
          Icon(
            Icons.double_arrow,
            color: Colors.black,
            size: 16,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (formattedTarget+formattedExercise-formattedFood).toString(),
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 18,
                    fontFamily: "SVN_Comic",
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Còn lại",
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 18,
                    fontFamily: "SVN_Comic",
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
