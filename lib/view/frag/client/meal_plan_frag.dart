import 'dart:convert';

import 'package:al_datn_my_health/api/ai_api.dart';
import 'package:al_datn_my_health/api/sever_api.dart';
import 'package:al_datn_my_health/model/req/add_meal_req.dart';
import 'package:al_datn_my_health/model/req/get_meal_plan_req.dart';
import 'package:al_datn_my_health/model/req/replace_meal_req.dart';
import 'package:al_datn_my_health/view/dialog/confirm_add_dish_dialog.dart';
import 'package:al_datn_my_health/view/frag/client/meal_plan_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common_utils.dart';
import '../../../model/res/get_meal_plan_res.dart';
import '../../act/client/detail_dish.dart';
import '../../custom_view/item_meals.dart';

class MealPlanFrag extends StatefulWidget {
  @override
  _MealPlanFragState createState() => _MealPlanFragState();
}

class _MealPlanFragState extends State<MealPlanFrag> {
  GetMealPlanRes? getMealPlanRes;
  bool isLoading = false;

  final String CACHE_KEY_DATA = "CACHE_MEAL_PLAN_DATA";
  final String CACHE_KEY_USER_ID = "CACHE_MEAL_PLAN_OWNER_ID";

  @override
  void initState() {
    super.initState();
    _initDataStrategy();
  }

  Future<void> _initDataStrategy() async {
    setState(() {
      isLoading = true;
    });
    final idUserInfo = await CommonUtils().getPref("idUserInfo");
    final currentUserId = int.tryParse(idUserInfo.toString());

    if (currentUserId != null) {
      bool isCacheValid = await _checkCacheValidity(currentUserId);

      if (isCacheValid) {
        await _loadFromCache();
      } else {
        await _fetchAndSaveFromApi(currentUserId);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _onRefreshPressed() async {
    setState(() {
      isLoading = true;
    });
    final idUserInfo = await CommonUtils().getPref("idUserInfo");
    final currentUserId = int.tryParse(idUserInfo.toString());

    if (currentUserId != null) {
      await _fetchAndSaveFromApi(currentUserId);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Image.asset('assets/images/ic_logo_app.png', width: 56, height: 56),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Khuyến nghị',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: "SVN_SAF", fontSize: 24, color: Colors.green),
                ),
              ),
            ),
            IconButton(
              onPressed: isLoading ? null : _onRefreshPressed,
              icon: Icon(Icons.refresh, color: Colors.green),
              tooltip: "Tạo thực đơn mới",
            ),
          ],
        ),
        Container(height: 1, color: Colors.green),
        Expanded(
          child:
              isLoading
                  ? const MealPlanShimmer()
                  : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getMealPlanRes == null || getMealPlanRes!.response == null
                            ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text("Không có dữ liệu thực đơn. Hãy thử tải lại."),
                              ),
                            )
                            : SingleChildScrollView(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (getMealPlanRes!.response!.reason.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 16.0),
                                      child: Text(
                                        getMealPlanRes!.response!.reason,
                                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[700]),
                                      ),
                                    ),
                                  ...getMealPlanRes!.response!.meals.map((session) {
                                    return ItemMeals(
                                      mealSession: session,
                                      onAdd: (item) {
                                        _handleAddDish(session, item);
                                      },
                                      onSwap: (item) {
                                        _handleSwapDish(session, item);
                                      },
                                      onDetail: (item) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => DetailDishAct(dishName: item.name)),
                                        );
                                      },
                                    );
                                  }),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),
        ),
      ],
    );
  }

  Future<void> _handleAddDish(MealSession session, MealItem item) async {
    double ratio = 1.0;
    try {
      ratio = double.parse(item.portionScale.toString());
    } catch (e) {
      ratio = 1.0;
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmAddDishDialog(
        dishName: item.name,
        mealName: session.mealName,
        ratio: ratio,
      ),
    );

    if (result != null) {
      final int dishId = result['dishId'];
      final double weight = result['weight'];
      await _executeAddMealApi(dishId, weight, session.mealName);
    }
  }

  Future<void> _executeAddMealApi(int dishId, double weight, String mealType) async {
    setState(() {
      isLoading = true;
    });

    try {
      final idUserInfo = await CommonUtils().getPref("idUserInfo");
      final userId = int.tryParse(idUserInfo.toString());

      if (userId == null) {
        Fluttertoast.showToast(msg: "Lỗi thông tin người dùng");
        return;
      }

      final now = DateTime.now();
      final formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

      final req = AddMealReq(
        userId: userId,
        dishId: dishId,
        weight: weight,
        mealType: _mapToApiMealType(mealType),
        date: formattedDate,
      );

      // Gọi Server API
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
      } else {
        await Fluttertoast.showToast(
          msg: "Chưa thể thêm món ăn (Lỗi Server)!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("Error Add Meal: $e");
      Fluttertoast.showToast(msg: "Lỗi kết nối khi thêm món!");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _mapToApiMealType(String displayMealName) {
    String name = displayMealName.toLowerCase().trim();
    if (name.contains('sáng') || name.contains('breakfast') || name.contains('morning')) {
      return 'breakfast';
    }
    else if (name.contains('trưa') || name.contains('lunch') || name.contains('noon')) {
      return 'lunch';
    }
    else if (name.contains('tối') || name.contains('dinner') || name.contains('night')) {
      return 'dinner';
    }
    return 'breakfast';
  }

  Future<void> _handleSwapDish(MealSession session, MealItem oldItem) async {
    setState(() {
      isLoading = true;
    });

    try {
      final idUserInfo = await CommonUtils().getPref("idUserInfo");
      final userId = int.tryParse(idUserInfo.toString());

      if (userId == null) return;

      final req = ReplaceMealReq(userId: userId.toString(), foodOld: oldItem);

      final res = await AiApi().swapMeal(req);

      MealItem? newItem = res?.response?.bestReplacement;

      if (newItem != null && getMealPlanRes?.response != null) {
        var targetSession = getMealPlanRes!.response!.meals.firstWhere((s) => s.mealName == session.mealName);

        int index = targetSession.items.indexOf(oldItem);

        if (index != -1) {
          targetSession.items[index] = newItem;

          setState(() {
            // Cập nhật lại UI
          });

          await _saveToCache(userId, getMealPlanRes!);

          Fluttertoast.showToast(msg: "Đã đổi thành: ${newItem.name}");
        }
      } else {
        Fluttertoast.showToast(msg: "Không tìm được món thay thế phù hợp");
      }
    } catch (e) {
      print("Lỗi swap: $e");
      Fluttertoast.showToast(msg: "Lỗi khi đổi món");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> _checkCacheValidity(int currentUserId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int? cachedUserId = prefs.getInt(CACHE_KEY_USER_ID);
      if (cachedUserId != null && cachedUserId == currentUserId) {
        if (prefs.containsKey(CACHE_KEY_DATA)) {
          return true;
        }
      }
    } catch (e) {
      print("Lỗi check cache: $e");
    }
    return false;
  }

  Future<void> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString(CACHE_KEY_DATA);

      if (jsonString != null && jsonString.isNotEmpty) {
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        setState(() {
          getMealPlanRes = GetMealPlanRes.fromJson(jsonMap);
        });
        print("Đã load dữ liệu từ Cache (ID khớp)");
      }
    } catch (e) {
      print("Lỗi parse cache: $e");
    }
  }

  Future<void> _fetchAndSaveFromApi(int userId) async {
    final req = GetMealPlanReq(userId: userId.toString(), mealsToGenerate: ["sáng", "trưa", "tối"]);
    final res = await AiApi().getMealPlan(req);

    if (res != null) {
      setState(() {
        getMealPlanRes = res;
      });
      _saveToCache(userId, res);
    } else {
      await Fluttertoast.showToast(
        msg: "Kết nối không ổn định!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _saveToCache(int userId, GetMealPlanRes data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(CACHE_KEY_USER_ID, userId);
      String jsonString = jsonEncode(data.toJson());
      await prefs.setString(CACHE_KEY_DATA, jsonString);
      print("Đã lưu Cache mới kèm ID: $userId");
    } catch (e) {
      print("Lỗi lưu cache: $e");
    }
  }
}
