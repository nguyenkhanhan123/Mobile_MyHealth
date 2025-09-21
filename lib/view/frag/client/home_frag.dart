import 'dart:math';

import 'package:al_datn_my_health/view/act/client/stat_act.dart';
import 'package:flutter/material.dart';

import '../../../model/item_nutrients.dart';
import '../../custom_view/item_title.dart';
import '../../custom_view/list_nutrients_view.dart';

class HomeFrag extends StatefulWidget {
  @override
  _HomeFragState createState() => _HomeFragState();
}

class _HomeFragState extends State<HomeFrag> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatDateTime(_selectedDate),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "SVN_Comic",
                    ),
                  ),
                  Text(
                    'Cùng nhau, chúng ta làm được tất cả!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "SVN_Comic",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(5),
              child: IconButton(
                onPressed: () async {
                  final selectedDate = await Navigator.push<DateTime>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatAct(dateTime: _selectedDate),
                    ),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  }
                },
                icon: Icon(Icons.calendar_month, size: 28, color: Colors.black),
              ),
            ),
          ],
        ),
        Container(height: 1, color: Colors.green),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ItemTitle(icon: Icons.local_fire_department,text: 'Tổng quan'),
                ListNutrientsView(items: generateFakeItems(2)),
                ItemTitle(icon: Icons.ramen_dining,text: 'Carbohydrate (Glucid)'),
                ListNutrientsView(items: generateFakeItems(3)),
                ItemTitle(icon: Icons.fastfood_outlined,text: 'Fat (Lipid)'),
                ListNutrientsView(items: generateFakeItems(5)),
                ItemTitle(icon: Icons.water_drop,text: 'Vitamin'),
                ListNutrientsView(items: generateFakeItems(14)),
                ItemTitle(icon: Icons.terrain,text: 'Khoáng chất'),
                ListNutrientsView(items: generateFakeItems(11)),
                ItemTitle(icon: Icons.emoji_food_beverage,text: 'Khác'),
                ListNutrientsView(items: generateFakeItems(4))
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    const weekdays = [
      'THỨ 2',
      'THỨ 3',
      'THỨ 4',
      'THỨ 5',
      'THỨ 6',
      'THỨ 7',
      'CHỦ NHẬT',
    ];
    const months = [
      'THÁNG 1',
      'THÁNG 2',
      'THÁNG 3',
      'THÁNG 4',
      'THÁNG 5',
      'THÁNG 6',
      'THÁNG 7',
      'THÁNG 8',
      'THÁNG 9',
      'THÁNG 10',
      'THÁNG 11',
      'THÁNG 12',
    ];
    String weekday =
        dateTime.weekday == 7 ? weekdays[6] : weekdays[dateTime.weekday - 1];
    String month = months[dateTime.month - 1];
    return '$weekday, ${dateTime.day} $month';
  }

  List<ItemNutrients> generateFakeItems(int count) {
    final random = Random();
    return List.generate(count, (i) {
      return ItemNutrients(
        name: "Nutrient ${i + 1}",
        unit: "g",
        used: random.nextInt(150),
        total: 100,
      );
    });
  }
}
