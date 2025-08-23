import 'dart:math';

import 'package:al_datn_my_health/model/item_nutrients.dart';
import 'package:al_datn_my_health/view/custom_view/circle.dart';
import 'package:flutter/material.dart';

class ItemNutrientsView extends StatefulWidget {
  final ItemNutrients itemNutrients;

  const ItemNutrientsView({
    super.key,
    required this.itemNutrients,
  });

  @override
  _ItemNutrientsViewState createState() {
    return _ItemNutrientsViewState();
  }
}

class _ItemNutrientsViewState extends State<ItemNutrientsView> {
  @override
  Widget build(BuildContext context) {
    double sweepAngleDeg;
    Color colorBg;
    Color color;
    if (widget.itemNutrients.used >= widget.itemNutrients.total) {
      sweepAngleDeg = 360;
      colorBg=Colors.redAccent;
      color=getColdColor();
    } else {
      sweepAngleDeg = widget.itemNutrients.used / widget.itemNutrients.total * 360;
      colorBg=Colors.greenAccent;
      color=getWarmColor();
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.itemNutrients.name,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontFamily: "SVN_Comic",
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Circle(
                size: 105,
                strokeWidth: 6,
                sweepAngleDeg: sweepAngleDeg,
                color: colorBg,
                backgroundColor: color,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.itemNutrients.used.toString(),
                    style: TextStyle(
                      color: color,
                      fontSize: 16,
                      fontFamily: "SVN_Comic",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "/${widget.itemNutrients.total}${widget.itemNutrients.unit}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "SVN_Comic",
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "Còn lại ${widget.itemNutrients.total - widget.itemNutrients.used}${widget.itemNutrients.unit}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: "SVN_Comic",
            ),
          ),
        ],
      ),
    );
  }

  Color getWarmColor() {
    final random = Random();
    double hue;
    if (random.nextBool()) {
      hue = random.nextDouble() * 60;
    } else {
      hue = 200 + random.nextDouble() * 160;
    }
    double saturation = 0.6 + random.nextDouble() * 0.2;
    double lightness = 0.4 + random.nextDouble() * 0.2;
    return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
  }

  Color getColdColor() {
    final random = Random();
    double hue = 120 + random.nextDouble() * 120;
    double saturation = 0.6 + random.nextDouble() * 0.2;
    double lightness = 0.4 + random.nextDouble() * 0.2;
    return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
  }
}
