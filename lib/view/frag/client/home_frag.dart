import 'package:al_datn_my_health/model/req/get_total_water_req.dart';
import 'package:al_datn_my_health/view/act/client/stat_act.dart';
import 'package:flutter/material.dart';

import '../../../api/sever_api.dart';
import '../../../common_utils.dart';
import '../../../model/item_nutrients.dart';
import '../../../model/req/get_kcal_exercise_req.dart';
import '../../../model/req/get_nutri_meal_req.dart';
import '../../../model/res/get_nutri_meal_res.dart';
import '../../../model/res/get_required_index_res.dart';
import '../../custom_view/item_title.dart';
import '../../custom_view/list_nutrients_view.dart';

class HomeFrag extends StatefulWidget {
  @override
  _HomeFragState createState() => _HomeFragState();
}

class _HomeFragState extends State<HomeFrag> {
  DateTime _selectedDate = DateTime.now();
  double kcalExercise = 0;
  double totalWater = 0;
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

    await Future.wait([
      _loadExercise(),
      _loadMeal(),
      _loadRequiredIndex(),
      _loadTotalWater(),
    ]);

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadExercise() async {
    final idUserInfo = await CommonUtils().getPref("idUserInfo");
    final result = int.tryParse(idUserInfo.toString());

    final formattedDate =
        "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

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

    final formattedDate =
        "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

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

  Future<void> _loadTotalWater() async {
    final idUserInfo = await CommonUtils().getPref("idUserInfo");
    final result = int.tryParse(idUserInfo.toString());

    final formattedDate =
        "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

    if (result != null) {
      final value = await _getTotalWater(result, formattedDate);
      if (value != null) {
        setState(() {
          totalWater = value;
        });
      } else {
        setState(() {
          totalWater = 0;
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
              child: Image.asset(
                'assets/images/ic_logo_app.png',
                width: 45,
                height: 45,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(3),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
            ),
            Padding(
              padding: EdgeInsets.all(3),
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
                    _loadAllData();
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
                  ? Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  )
                  : SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ItemTitle(
                            icon: Icons.local_fire_department,
                            text: 'Tổng quan',
                          ),
                          ListNutrientsView(
                            items: [
                              ItemNutrients(
                                name: "Năng lượng",
                                used: nutriMeal?.kcal ?? 0 - kcalExercise,
                                total: requiredIndex?.targetCalories ?? 0,
                                unit: "kcal",
                              ),
                              ItemNutrients(
                                name: "Protein",
                                used: nutriMeal?.protein ?? 0,
                                total: requiredIndex?.protein ?? 0,
                                unit: "g",
                              ),
                              ItemNutrients(
                                name: "Chất béo",
                                used: nutriMeal?.totalFats ?? 0,
                                total: requiredIndex?.totalFat ?? 0,
                                unit: "g",
                              ),
                              ItemNutrients(
                                name: "Carbohydrate",
                                used: nutriMeal?.totalCarbs ?? 0,
                                total: requiredIndex?.carbohydrate ?? 0,
                                unit: "g",
                              ),
                            ],
                          ),
                          ItemTitle(
                            icon: Icons.ramen_dining,
                            text: 'Carbohydrate (Glucid)',
                          ),
                          ListNutrientsView(
                            items: [
                              ItemNutrients(
                                name: "Tinh bột",
                                used: nutriMeal?.carbs ?? 0,
                                total: requiredIndex?.carbs ?? 0,
                                unit: "g",
                              ),
                              ItemNutrients(
                                name: "Đường",
                                used: nutriMeal?.sugar ?? 0,
                                total: requiredIndex?.sugar ?? 0,
                                unit: "g",
                              ),
                              ItemNutrients(
                                name: "Chất xơ",
                                used: nutriMeal?.fiber ?? 0,
                                total: requiredIndex?.fiber ?? 0,
                                unit: "g",
                              ),
                            ],
                          ),
                          ItemTitle(
                            icon: Icons.fastfood_outlined,
                            text: 'Fat (Lipid)',
                          ),
                          ListNutrientsView(
                            items: [
                              ItemNutrients(
                                name: "SaturatedFat",
                                used: nutriMeal?.saturatedFat ?? 0,
                                total: requiredIndex?.saturatedFat ?? 0,
                                unit: "g",
                              ),
                              ItemNutrients(
                                name: "MonounSaturatedFat",
                                used: nutriMeal?.monounSaturatedFat ?? 0,
                                total: requiredIndex?.monounSaturatedFat ?? 0,
                                unit: "g",
                              ),
                              ItemNutrients(
                                name: "PolyunSaturatedFat",
                                used: nutriMeal?.polyunSaturatedFat ?? 0,
                                total: requiredIndex?.polyunSaturatedFat ?? 0,
                                unit: "g",
                              ),
                              ItemNutrients(
                                name: "TransFat",
                                used: nutriMeal?.transFat ?? 0,
                                total: requiredIndex?.transfat ?? 0,
                                unit: "g",
                              ),
                            ],
                          ),
                          ItemTitle(icon: Icons.water_drop, text: 'Vitamin'),
                          ListNutrientsView(
                            items: [
                              ItemNutrients(
                                name: "Vitamin A",
                                used: nutriMeal?.vitaminA ?? 0,
                                total: requiredIndex?.vitamina ?? 0,
                                unit: "IU",
                              ),
                              ItemNutrients(
                                name: "Vitamin B6",
                                used: nutriMeal?.vitaminB6 ?? 0,
                                total: requiredIndex?.vitaminb6 ?? 0,
                                unit: "mg",
                              ),
                              ItemNutrients(
                                name: "Vitamin B12",
                                used: nutriMeal?.vitaminB12 ?? 0,
                                total: requiredIndex?.vitaminb12 ?? 0,
                                unit: "µg",
                              ),
                              ItemNutrients(
                                name: "Vitamin C",
                                used: nutriMeal?.vitaminC ?? 0,
                                total: requiredIndex?.vitaminc ?? 0,
                                unit: "mg",
                              ),
                              ItemNutrients(
                                name: "Vitamin D",
                                used: nutriMeal?.vitaminD ?? 0,
                                total: requiredIndex?.vitamind ?? 0,
                                unit: "µg",
                              ),
                              ItemNutrients(
                                name: "Vitamin E",
                                used: nutriMeal?.vitaminE ?? 0,
                                total: requiredIndex?.vitamine ?? 0,
                                unit: "mg",
                              ),
                              ItemNutrients(
                                name: "Vitamin K",
                                used: nutriMeal?.vitaminK ?? 0,
                                total: requiredIndex?.vitamink ?? 0,
                                unit: "µg",
                              ),
                              ItemNutrients(
                                name: "Choline",
                                used: nutriMeal?.choline ?? 0,
                                total: requiredIndex?.choline ?? 0,
                                unit: "mg",
                              ),
                            ],
                          ),
                          ItemTitle(icon: Icons.terrain, text: 'Khoáng chất'),
                          ListNutrientsView(
                            items: [
                              ItemNutrients(
                                name: "Canxi",
                                used: nutriMeal?.canxi ?? 0,
                                total: requiredIndex?.canxi ?? 0,
                                unit: "mg",
                              ),
                              ItemNutrients(
                                name: "Sắt",
                                used: nutriMeal?.fe ?? 0,
                                total: requiredIndex?.fe ?? 0,
                                unit: "mg",
                              ),
                              ItemNutrients(
                                name: "Magie",
                                used: nutriMeal?.magie ?? 0,
                                total: requiredIndex?.magie ?? 0,
                                unit: "mg",
                              ),
                              ItemNutrients(
                                name: "Photpho",
                                used: nutriMeal?.photpho ?? 0,
                                total: requiredIndex?.photpho ?? 0,
                                unit: "mg",
                              ),
                              ItemNutrients(
                                name: "Kali",
                                used: nutriMeal?.kali ?? 0,
                                total: requiredIndex?.kali ?? 0,
                                unit: "mg",
                              ),
                              ItemNutrients(
                                name: "Natri",
                                used: nutriMeal?.natri ?? 0,
                                total: requiredIndex?.natri ?? 0,
                                unit: "mg",
                              ),
                              ItemNutrients(
                                name: "Kẽm",
                                used: nutriMeal?.zn ?? 0,
                                total: requiredIndex?.zn ?? 0,
                                unit: "mg",
                              ),
                            ],
                          ),
                          ItemTitle(
                            icon: Icons.emoji_food_beverage,
                            text: 'Khác',
                          ),
                          ListNutrientsView(
                            items: [
                              ItemNutrients(
                                name: "Nước",
                                used: nutriMeal?.water ?? 0 + totalWater,
                                total: requiredIndex?.water ?? 0,
                                unit: "ml",
                              ),
                              ItemNutrients(
                                name: "Caffein",
                                used: nutriMeal?.caffeine ?? 0,
                                total: requiredIndex?.caffeine ?? 0,
                                unit: "mg",
                              ),
                              ItemNutrients(
                                name: "Alcohol",
                                used: nutriMeal?.alcohol ?? 0,
                                total: requiredIndex?.alcohol ?? 0,
                                unit: "g",
                              ),
                              ItemNutrients(
                                name: "Cholesterol",
                                used: nutriMeal?.cholesterol ?? 0,
                                total: requiredIndex?.cholesterol ?? 0,
                                unit: "mg",
                              ),
                            ],
                          ),
                        ],
                      ),
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

  Future<double?> _getTotalWater(int userId, String date) async {
    final req = GetTotalWaterReq(userId: userId, date: date);
    final res = await SeverApi().getTotalWater(req);
    if (res != null && res.message == "Find successful") {
      return res.totalWater;
    } else {
      return null;
    }
  }
}
