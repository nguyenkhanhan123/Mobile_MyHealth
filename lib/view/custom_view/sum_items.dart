import 'package:flutter/material.dart';

class SumItems extends StatelessWidget {
  final double calo;
  final double protein;
  final double fat;
  final double carbs;

  const SumItems({super.key, required this.calo, required this.protein, required this.fat, required this.carbs});

  @override
  Widget build(BuildContext context) {
    final double caloVal = double.parse(calo.toStringAsFixed(2));
    final double proteinVal = double.parse(protein.toStringAsFixed(2));
    final double fatVal = double.parse(fat.toStringAsFixed(2));
    final double carbsVal = double.parse(carbs.toStringAsFixed(2));
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 4,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/ic_calo.png', width: 20, height: 20),
              SizedBox(width: 3),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${caloVal.round()} kcal",
                    style: TextStyle(color: Colors.red, fontSize: 16, fontFamily: "SVN_Comic"),
                  ),
                  Text("Calo", style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: "SVN_Comic")),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/ic_protein.png', width: 20, height: 20),
              SizedBox(width: 3),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${proteinVal.round()} g",
                    style: TextStyle(color: Colors.blue, fontSize: 16, fontFamily: "SVN_Comic"),
                  ),
                  Text("Protein", style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: "SVN_Comic")),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/ic_fat.png', width: 20, height: 20),
              SizedBox(width: 3),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${fatVal.round()} g",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 16, fontFamily: "SVN_Comic"),
                  ),
                  Text("Chất béo", style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: "SVN_Comic")),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/ic_carbs.png', width: 20, height: 20),
              SizedBox(width: 3),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${carbsVal.round()} g",
                    style: TextStyle(color: Colors.green, fontSize: 16, fontFamily: "SVN_Comic"),
                  ),
                  Text("Carbs", style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: "SVN_Comic")),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
