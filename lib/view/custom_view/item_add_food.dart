import 'package:al_datn_my_health/model/req/add_dish_req.dart';
import 'package:flutter/material.dart';

import '../../model/res/info_dish_res.dart';
import '../../model/res/list_food_res.dart';

class ItemAddFood extends StatefulWidget {
  final InfoFood infoFood;

  const ItemAddFood({super.key, required this.infoFood});

  @override
  State<ItemAddFood> createState() => _ItemAddFoodState();
}

class _ItemAddFoodState extends State<ItemAddFood> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.infoFood.thumbnail,
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.infoFood.name,
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
                    Text(
                      "100 g, ${widget.infoFood.kcal} kcal",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontFamily: "SVN_Comic",
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: Text(
                            "Khối lượng nguyên liệu",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: "SVN_Comic",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Row(
                            children: [
                              SizedBox(
                                width: 65,
                                child: TextField(
                                  controller: _controller,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.green,
                                  textAlign: TextAlign.center,
                                  maxLength: 5,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                        width: 3,
                                      ),
                                    ),
                                    counterText: "",
                                  ),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "SVN_Comic",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                getShortUnit(widget.infoFood.baseUnit),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: "SVN_Comic",
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                "Đồng ý",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 20,
                                  fontFamily: "SVN_Comic",
                                ),
                              ),
                              onPressed: () {
                                double? value =
                                    double.tryParse(_controller.text.trim()) ??
                                    0;
                                Navigator.pop(context);
                                Navigator.pop(context, Ingredient(
                                    ingredientId: widget.infoFood.id,
                                    weight: value,
                                  thumbnail: widget.infoFood.thumbnail,
                                  name: widget.infoFood.name,
                                  unit:widget.infoFood.baseUnit
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                  );
                },
                icon: Icon(Icons.add, size: 28, color: Colors.black),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.info_outline_rounded,
                  size: 28,
                  color: Colors.black,
                ),
              ),
            ],
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
