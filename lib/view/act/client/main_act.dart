import 'package:al_datn_my_health/view/frag/client/ai_frag.dart';
import 'package:al_datn_my_health/view/frag/client/home_frag.dart';
import 'package:al_datn_my_health/view/frag/client/meal_plan_frag.dart';
import 'package:al_datn_my_health/view/frag/client/note_frag.dart';
import 'package:al_datn_my_health/view/frag/client/settings_frag.dart';
import 'package:flutter/material.dart';

class MainAct extends StatefulWidget {
  @override
  State<MainAct> createState() => _MainActState();
}

class _MainActState extends State<MainAct> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Offstage(
              offstage: _currentIndex != 2,
              child: MealPlanFrag(),
            ),
            Offstage(
              offstage: _currentIndex != 3,
              child: AiFrag(),
            ),
            if (_currentIndex == 0) HomeFrag(),
            if (_currentIndex == 1) NoteFrag(),
            if (_currentIndex == 4) SettingsFrag(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 11),
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 21),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Theo dõi'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Nhật ký'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Khuyến nghị'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Chuyên gia'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
      ),
    );
  }
}