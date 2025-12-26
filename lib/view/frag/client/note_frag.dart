import 'package:al_datn_my_health/model/req/get_kcal_exercise_req.dart';
import 'package:al_datn_my_health/model/req/get_nutri_meal_req.dart';
import 'package:al_datn_my_health/model/res/get_nutri_meal_res.dart';
import 'package:al_datn_my_health/model/res/get_required_index_res.dart';
import 'package:al_datn_my_health/view/act/client/add_drink_schedule.dart';
import 'package:al_datn_my_health/view/act/client/add_exercise_schedule.dart';
import 'package:al_datn_my_health/view/act/client/add_food_schedule.dart';
import 'package:al_datn_my_health/view/act/client/stat_act.dart';
import 'package:al_datn_my_health/view/custom_view/item_title.dart';
import 'package:al_datn_my_health/view/custom_view/item_type_note.dart';
import 'package:al_datn_my_health/view/custom_view/not_used_calories.dart';
import 'package:al_datn_my_health/view/custom_view/sum_items.dart';
import 'package:flutter/material.dart';

import '../../../api/sever_api.dart';
import '../../../common_utils.dart';

class NoteFrag extends StatefulWidget {
  @override
  _NoteFragState createState() => _NoteFragState();
}

class _NoteFragState extends State<NoteFrag> {
  DateTime _selectedDate = DateTime.now();
  double kcalExercise = 0;
  NutriMeal? nutriMeal;
  RequiredIndex? requiredIndex;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() {
      isLoading = true;
    });
    await Future.wait([_loadExercise(), _loadMeal(), _loadRequiredIndex()]);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadExercise() async {
    final idUserInfo = await CommonUtils().getPref("idUserInfo");
    final result = int.tryParse(idUserInfo.toString());

    final formattedDate = "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

    if (result != null) {
      final kcal = await _getTotalExerciseKcal(result, formattedDate);
      if (kcal != null) {
        setState(() {
          kcalExercise = kcal;
        });
      } else {
        setState(() {
          kcalExercise = 0;
        });
      }
    }
  }

  Future<void> _loadMeal() async {
    final idUserInfo = await CommonUtils().getPref("idUserInfo");
    final result = int.tryParse(idUserInfo.toString());

    final formattedDate = "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

    if (result != null) {
      final value = await _getNutriMeal(result, formattedDate);
      if (value != null) {
        setState(() {
          nutriMeal = value;
        });
      } else {
        setState(() {
          nutriMeal = null;
        });
      }
    }
  }

  Future<void> _loadRequiredIndex() async {
    final idUserInfo = await CommonUtils().getPref("idUserInfo");
    final result = int.tryParse(idUserInfo.toString());

    if (result != null) {
      final value = await _getRequiredIndex(result);
      if (value != null) {
        setState(() {
          requiredIndex = value;
        });
      } else {
        setState(() {
          requiredIndex = null;
        });
      }
    }
  }

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
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
              child: Image.asset('assets/images/ic_logo_app.png', width: 45, height: 45),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_formatDateTime(_selectedDate), style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "SVN_Comic")),
                    Text(
                      'Cùng nhau, chúng ta làm được tất cả!',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: "SVN_Comic", fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: IconButton(
                onPressed: () async {
                  final selectedDate = await Navigator.push<DateTime>(
                    context,
                    MaterialPageRoute(builder: (context) => StatAct(dateTime: _selectedDate)),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _selectedDate = selectedDate;
                      _loadAllData();
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
          child:
              isLoading
                  ? Center(child: CircularProgressIndicator(color: Colors.green))
                  : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ItemTitle(icon: Icons.local_fire_department, text: 'Calo còn lại'),
                        NotUsedCalories(target: requiredIndex?.targetCalories ?? 0, exercise: kcalExercise, food: nutriMeal?.kcal ?? 0),
                        ItemTitle(icon: Icons.menu, text: 'Tổng số hằng ngày'),
                        SumItems(
                          calo: nutriMeal?.kcal ?? 0,
                          protein: nutriMeal?.protein ?? 0,
                          fat:
                              (nutriMeal?.monounSaturatedFat ?? 0) +
                              (nutriMeal?.polyunSaturatedFat ?? 0) +
                              (nutriMeal?.saturatedFat ?? 0) +
                              (nutriMeal?.transFat ?? 0),
                          carbs: (nutriMeal?.sugar ?? 0) + (nutriMeal?.fiber ?? 0) + (nutriMeal?.carbs ?? 0),
                        ),
                        ItemTitle(icon: Icons.directions_run, text: 'Tập thể dục'),
                        ItemTypeNote(
                          pathImg: "assets/images/ic_exercise2.png",
                          text: "Khỏe mạnh từ hôm nay, tự tin cho ngày mai.",
                          onPressed: () async {
                            final result = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(builder: (context) => AddExerciseSchedule(selectedDate: _selectedDate)),
                            );
                            if (result == true) {
                              _loadAllData();
                            }
                          },
                          text2: "Ghi nhật ký bài tập",
                        ),
                        ItemTitle(icon: Icons.local_drink_outlined, text: 'Nước'),
                        ItemTypeNote(
                          pathImg: "assets/images/ic_glass_water.png",
                          text: "Nước: người bạn đồng hành của sức khỏe.",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddDrinkSchedule(selectedDate: _selectedDate)));
                          },
                          text2: "Ghi lại nước",
                        ),
                        ItemTitle(icon: Icons.sunny_snowing, text: 'Bữa sáng'),
                        ItemTypeNote(
                          pathImg: "assets/images/ic_breakfast.png",
                          text: "Ăn sáng đầy đủ – Năng lượng tràn đầy cả ngày.",
                          onPressed: () async {
                            final result = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(builder: (context) => AddFoodSchedule(mealType: "breakfast", selectedDate: _selectedDate)),
                            );
                            if (result == true) {
                              _loadAllData();
                            }
                          },
                          text2: "Ghi lại thực phẩm",
                        ),
                        ItemTitle(icon: Icons.wb_sunny, text: 'Bữa trưa'),
                        ItemTypeNote(
                          pathImg: "assets/images/ic_lunch.png",
                          text: "Nạp năng lượng buổi trưa để tiếp tục bứt phá.",
                          onPressed: () async {
                            final result = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(builder: (context) => AddFoodSchedule(mealType: "lunch", selectedDate: _selectedDate)),
                            );
                            if (result == true) {
                              _loadAllData();
                            }
                          },
                          text2: "Ghi lại thực phẩm",
                        ),
                        ItemTitle(icon: Icons.nights_stay, text: 'Bữa tối'),
                        ItemTypeNote(
                          pathImg: "assets/images/ic_dinner.png",
                          text: "Bữa tối nhẹ nhàng – Ngủ ngon giấc.",
                          onPressed: () async {
                            final result = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(builder: (context) => AddFoodSchedule(mealType: "dinner", selectedDate: _selectedDate)),
                            );
                            if (result == true) {
                              _loadAllData();
                            }
                          },
                          text2: "Ghi lại thực phẩm",
                        ),
                        ItemTitle(icon: Icons.local_cafe, text: 'Đồ ăn nhẹ'),
                        ItemTypeNote(
                          pathImg: "assets/images/ic_fruits.png",
                          text: "Ăn nhẹ xanh – Cơ thể an lành.",
                          onPressed: () async {
                            final result = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(builder: (context) => AddFoodSchedule(mealType: "snack", selectedDate: _selectedDate)),
                            );
                            if (result == true) {
                              _loadAllData();
                            }
                          },
                          text2: "Ghi lại thực phẩm",
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    const weekdays = ['THỨ 2', 'THỨ 3', 'THỨ 4', 'THỨ 5', 'THỨ 6', 'THỨ 7', 'CHỦ NHẬT'];
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
    String weekday = dateTime.weekday == 7 ? weekdays[6] : weekdays[dateTime.weekday - 1];
    String month = months[dateTime.month - 1];
    return '$weekday, ${dateTime.day} $month';
  }

  Future<double?> _getTotalExerciseKcal(int userId, String date) async {
    final req = GetKcalExerciseReq(userId: userId, date: date);
    final res = await SeverApi().getTotalExerciseKcal(req);
    if (res != null && res.message == "Find successful") {
      return res.totalKcal;
    } else {
      return null;
    }
  }

  Future<NutriMeal?> _getNutriMeal(int userId, String date) async {
    final req = GetNutriMealReq(userId: userId, date: date);
    final res = await SeverApi().getNutriMealKcal(req);
    if (res != null && res.message == "Find successful") {
      return res.nutriMeal;
    } else {
      return null;
    }
  }

  Future<RequiredIndex?> _getRequiredIndex(int userId) async {
    final res = await SeverApi().getRequiredIndexById(userId);
    if (res != null && res.message == "Find successful") {
      return res.requiredIndex;
    } else {
      return null;
    }
  }
}
