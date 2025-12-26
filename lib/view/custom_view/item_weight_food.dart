import 'package:flutter/material.dart';

import '../../model/res/info_dish_res.dart';

class ItemWeightFood extends StatefulWidget {
  final BasicIngredient ingredient;
  final VoidCallback onRemove;
  const ItemWeightFood({
    super.key,
    required this.ingredient,
    required this.onRemove,
  });

  @override
  _ItemWeightFoodState createState() => _ItemWeightFoodState();
}

class _ItemWeightFoodState extends State<ItemWeightFood> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Colors.grey, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.ingredient.thumbnail,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Image.asset(
                      'assets/images/ic_ingredients.png',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: widget.ingredient.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "SVN_Comic",
                    ),
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 12,
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                ],
              ),
            ),
          ),
          Text(
            widget.ingredient.weight.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "SVN_Comic",
              fontSize: 18,
            ),
          ),
          Text(
            getShortUnit(widget.ingredient.unit),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: "SVN_Comic",
            ),
          ),
          SizedBox(width: 4),
          IconButton(
            onPressed: widget.onRemove,
            icon: Icon(Icons.cancel_outlined, size: 24, color: Colors.black),
          ),
        ],
      ),
    );
  }

  String getShortUnit(String unit) {
    switch (unit.toLowerCase().trim()) {
      case "gram":
        return "g";
      case "thìa cà phê":
        return "tcp";
      case "ml":
        return "ml";
      default:
        return unit;
    }
  }
}
