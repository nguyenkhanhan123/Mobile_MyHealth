import 'package:flutter/material.dart';
import 'package:al_datn_my_health/model/item_nutrients.dart';
import 'item_nutrients_view.dart';

class ListNutrientsView extends StatelessWidget {
  final List<ItemNutrients> items;

  const ListNutrientsView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: items
            .map((item) => ItemNutrientsView(itemNutrients: item))
            .toList(),
      ),
    );
  }
}
