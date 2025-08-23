import 'dart:math';

import 'package:al_datn_my_health/model/item_nutrients.dart';
import 'package:al_datn_my_health/view/custom_view/item_nutrients_view.dart';
import 'package:al_datn_my_health/view/custom_view/list_nutrients_view.dart';
import 'package:al_datn_my_health/view/frag/home_frag.dart';
import 'package:flutter/material.dart';

class MainAct extends StatefulWidget {
  @override
  State<MainAct> createState() => _MainActState();
}

class _MainActState extends State<MainAct> {
  int _currentIndex = 0;

  Widget _buildFragment(int index) {
    switch (index) {
      case 0:
        return HomeFrag();
      case 1:
        return Center(child: Text("View2"));
      case 2:
        return Center(child: Text("View3"));
      case 3:
        return Center(child: Text("View4"));
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
            icon: Icon(Icons.grid_view_rounded),
            label: 'Theo dõi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Nhật ký',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Chuyên gia',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
        ],
      ),
    );
  }
}
