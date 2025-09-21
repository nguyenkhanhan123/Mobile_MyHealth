import 'package:flutter/material.dart';

class NotUsedCalories extends StatelessWidget {
  final int target;
  final int exercise;
  final double food;

  const NotUsedCalories({super.key, required this.target, required this.exercise, required this.food});

  @override
  Widget build(BuildContext context) {
    final int formattedFood=food.round();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                target.toString(),
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
                exercise.toString(),
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
                (target+exercise-formattedFood).toString(),
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
