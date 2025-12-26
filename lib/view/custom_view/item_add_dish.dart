import 'package:al_datn_my_health/common_utils.dart';
import 'package:al_datn_my_health/model/req/add_meal_req.dart';
import 'package:al_datn_my_health/model/res/list_dish_res.dart';
import 'package:al_datn_my_health/view/act/client/detail_dish.dart';
import 'package:al_datn_my_health/view/dialog/weight_dish_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api/sever_api.dart';

class ItemAddDish extends StatelessWidget {
  final InfoDish infoDish;
  final String mealType;

  final DateTime selectedDate;

  const ItemAddDish({
    super.key,
    required this.infoDish,
    required this.mealType,
    required this.selectedDate,
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
                    infoDish.thumbnail,
                    width: 132,
                    height: 75,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Image.asset(
                          'assets/images/ic_ingredients.png',
                          width: 132,
                          height: 75,
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
                            text: infoDish.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "SVN_Comic",
                            ),
                          ),
                          if(infoDish.isConfirm==1)
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
                      "${infoDish.totalGram} g, ${infoDish.totalKcal} kcal",
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
                onPressed: () async {
                  final weight = await showDialog<double>(
                    context: context,
                    builder: (context) => const WeightDishDialog(),
                  );
                  final idUserInfo = await CommonUtils().getPref("idUserInfo");
                  final result = int.tryParse(idUserInfo.toString());

                  final formattedDate =
                      "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                  if (result != null && weight != null) {
                    final success = await _addMeal(
                      result,
                      infoDish.id,
                      mealType,
                      weight,
                      formattedDate,
                    );
                    if (success) {
                      Navigator.pop(context, true);
                    }
                  }
                },
                icon: Icon(Icons.add, size: 28, color: Colors.black),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDishAct(id: infoDish.id)));
                },
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

  Future<bool> _addMeal(
    int userId,
    int dishId,
    String mealType,
    double weight,
    String date,
  ) async {
    final req = AddMealReq(
      userId: userId,
      dishId: dishId,
      weight: weight,
      mealType: mealType,
      date: date,
    );
    final res = await SeverApi().addMeal(req);
    if (res != null && res.message == "Create meal successful") {
      await Fluttertoast.showToast(
        msg: "Thêm món ăn thành công!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    } else {
      await Fluttertoast.showToast(
        msg: "Chưa thể thêm món ăn hoặc kết nối không ổn định!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }
}
