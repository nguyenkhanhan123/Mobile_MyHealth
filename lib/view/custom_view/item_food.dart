import 'package:flutter/material.dart';

import '../../model/res/list_food_res.dart';

class ItemFood extends StatelessWidget {
  final InfoFood infoFood;

  const ItemFood({
    super.key,
    required this.infoFood
  });

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
                    infoFood.thumbnail,
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
                            text: infoFood.name,
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
                      "100 g, ${infoFood.kcal} kcal",
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
                onPressed: () {},
                icon: Icon(
                  Icons.edit_note_sharp,
                  size: 28,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete, size: 28, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
