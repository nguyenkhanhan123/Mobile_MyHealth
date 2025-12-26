import 'dart:math';

import 'package:al_datn_my_health/model/item_nutrients.dart';
import 'package:al_datn_my_health/view/custom_view/item_nutrients_view.dart';
import 'package:al_datn_my_health/view/custom_view/list_nutrients_view.dart';
import 'package:al_datn_my_health/view/frag/admin/dish_frag.dart';
import 'package:al_datn_my_health/view/frag/admin/food_frag.dart';
import 'package:al_datn_my_health/view/frag/client/home_frag.dart';
import 'package:al_datn_my_health/view/frag/client/note_frag.dart';
import 'package:flutter/material.dart';

import '../../frag/admin/notification_frag.dart';

class MainActAdmin extends StatefulWidget {
  @override
  _MainActAdminState createState() => _MainActAdminState();
}

class _MainActAdminState extends State<MainActAdmin> {
  int _currentIndex = 0;

  Widget _buildFragment(int index) {
    switch (index) {
      case 0:
        return Center(child: DishFrag());
      case 1:
        return Center(child: FoodFrag());
      case 2:
        return Center(child: NotificationFrag());
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildFragment(_currentIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 11),
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 21),
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Món ăn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Nguyên liệu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add),
            label: 'Thông báo',
          )
        ],
      ),
    );
  }
}
