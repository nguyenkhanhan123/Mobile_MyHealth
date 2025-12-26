import 'package:al_datn_my_health/model/req/account_req.dart';
import 'package:al_datn_my_health/model/req/add_dish_req.dart';
import 'package:al_datn_my_health/model/req/add_drink_req.dart';
import 'package:al_datn_my_health/model/req/add_exercise_req.dart';
import 'package:al_datn_my_health/model/req/add_ingredient_req.dart';
import 'package:al_datn_my_health/model/req/add_meal_req.dart';
import 'package:al_datn_my_health/model/req/add_notification_req.dart';
import 'package:al_datn_my_health/model/req/get_kcal_exercise_req.dart';
import 'package:al_datn_my_health/model/req/get_nutri_meal_req.dart';
import 'package:al_datn_my_health/model/req/get_total_water_req.dart';
import 'package:al_datn_my_health/model/req/search_req.dart';
import 'package:al_datn_my_health/model/req/stat_drink_in_day_req.dart';
import 'package:al_datn_my_health/model/res/add_dish_res.dart';
import 'package:al_datn_my_health/model/res/add_drink_res.dart';
import 'package:al_datn_my_health/model/res/add_exercise_res.dart';
import 'package:al_datn_my_health/model/res/add_notification_res.dart';
import 'package:al_datn_my_health/model/res/create_user_info_res.dart';
import 'package:al_datn_my_health/model/res/get_nutri_meal_res.dart';
import 'package:al_datn_my_health/model/res/get_required_index_res.dart';
import 'package:al_datn_my_health/model/res/get_total_water_res.dart';
import 'package:al_datn_my_health/model/res/list_dish_res.dart';
import 'package:al_datn_my_health/model/res/list_food_res.dart';
import 'package:al_datn_my_health/model/res/list_keyword_res.dart';
import 'package:al_datn_my_health/model/res/stat_drink_in_day_res.dart';
import 'package:al_datn_my_health/model/res/stat_meal_in_day_res.dart';
import 'package:al_datn_my_health/model/user_info.dart';
import 'package:dio/dio.dart';

import '../model/req/stat_exercise_in_day_req.dart';
import '../model/req/stat_meal_in_day_req.dart';
import '../model/res/add_ingredient_res.dart';
import '../model/res/add_meal_res.dart';
import '../model/res/delete_drink_of_user_res.dart';
import '../model/res/delete_exercise_of_user_res.dart';
import '../model/res/delete_meal_of_user_res.dart';
import '../model/res/get_kcal_exercise_res.dart';
import '../model/res/get_notification_res.dart';
import '../model/res/get_user_info_res.dart';
import '../model/res/info_dish_res.dart';
import '../model/res/info_ingredient_res.dart';
import '../model/res/list_exercise_res.dart';
import '../model/res/login_res.dart';
import '../model/res/register_res.dart';
import '../model/res/stat_exercise_in_day_res.dart';
import '../model/res/update_dish_res.dart';
import '../model/res/update_ingredient_res.dart';
import '../model/res/update_status_res.dart';
import '../model/res/update_userinfo_res.dart';

class SeverApi {
  final Dio _dio;

  SeverApi()
    : _dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.44:5000/', connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10)));

  Future<RegisterRes?> registerAccount(AccountReq req) async {
    try {
      final response = await _dio.post('register_account', data: req.toMap());
      return RegisterRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<LoginRes?> loginAccount(AccountReq req) async {
    try {
      final response = await _dio.post('login', data: req.toMap());
      return LoginRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<ListKeywordRes?> findSimilarFood(String keyword) async {
    try {
      final response = await _dio.get('similar_food', queryParameters: {"keyWord": keyword});
      return ListKeywordRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<ListFoodRes?> findFood(SearchReq req) async {
    try {
      final response = await _dio.get('find_food', queryParameters: req.toMap());
      return ListFoodRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<ListKeywordRes?> findSimilarDish(String keyword) async {
    try {
      final response = await _dio.get('similar_dish', queryParameters: {"keyWord": keyword});
      return ListKeywordRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<ListDishRes?> findDish(SearchReq req) async {
    try {
      final response = await _dio.get('find_dish', queryParameters: req.toMap());
      return ListDishRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<ListExerciseRes?> findExercise() async {
    try {
      final response = await _dio.get('get_exercise');
      return ListExerciseRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<LoginRes?> loginAdmin(AccountReq req) async {
    try {
      final response = await _dio.post('login_admin', data: req.toMap());
      return LoginRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<CreateUserInfoRes?> createUserInfo(UserInfo req) async {
    try {
      final response = await _dio.post('create_userinfo', data: req.toMap());
      return CreateUserInfoRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<UpdateUserinfoRes?> updateUserInfo(UserInfo req, int id) async {
    try {
      final response = await _dio.patch('update_userinfo', queryParameters: {"id": id}, data: req.toMap());
      return UpdateUserinfoRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<AddDishRes?> addDish(AddDishReq req) async {
    try {
      final response = await _dio.post('add_dish', data: req.toMap());
      return AddDishRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<AddIngredientRes?> addIngredient(AddIngredientReq req) async {
    try {
      final response = await _dio.post('add_ingredient', data: req.toMap());
      return AddIngredientRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<AddMealRes?> addMeal(AddMealReq req) async {
    try {
      final response = await _dio.post('add_meal', data: req.toMap());
      return AddMealRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<AddDrinkRes?> addDrink(AddDrinkReq req) async {
    try {
      final response = await _dio.post('add_drink', data: req.toMap());
      return AddDrinkRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<AddExerciseRes?> addExercise(AddExerciseReq req) async {
    try {
      final response = await _dio.post('add_exercise', data: req.toMap());
      return AddExerciseRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<AddNotificationRes?> addNotification(AddNotificationReq req) async {
    try {
      final response = await _dio.post('add_notification', data: req.toMap());
      return AddNotificationRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<GetKcalExerciseRes?> getTotalExerciseKcal(GetKcalExerciseReq req) async {
    try {
      final response = await _dio.get('total_kcal_exercise', queryParameters: req.toMap());
      return GetKcalExerciseRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<GetNutriMealRes?> getNutriMealKcal(GetNutriMealReq req) async {
    try {
      final response = await _dio.get('total_nutri_meal', queryParameters: req.toMap());
      return GetNutriMealRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<StatDrinkInDayRes?> statDrinkInDay(StatDrinkInDayReq req) async {
    try {
      final response = await _dio.get('stat_drink', queryParameters: req.toMap());
      return StatDrinkInDayRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<StatExerciseInDayRes?> statExerciseInDay(StatExerciseInDayReq req) async {
    try {
      final response = await _dio.get('stat_exercise', queryParameters: req.toMap());
      return StatExerciseInDayRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<StatMealInDayRes?> statMealInDay(StatMealInDayReq req) async {
    try {
      final response = await _dio.get('stat_meal', queryParameters: req.toMap());
      return StatMealInDayRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<DeleteExerciseOfUserRes?> deleteExerciseOfUser(int id) async {
    try {
      final response = await _dio.delete('delete_stat_exercise', queryParameters: {"id": id});
      return DeleteExerciseOfUserRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<DeleteDrinkOfUserRes?> deleteDrinkOfUser(int id) async {
    try {
      final response = await _dio.delete('delete_stat_drink', queryParameters: {"id": id});
      return DeleteDrinkOfUserRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<DeleteMealOfUserRes?> deleteMealOfUser(int id) async {
    try {
      final response = await _dio.delete('delete_stat_meal', queryParameters: {"id": id});
      return DeleteMealOfUserRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<InfoDishRes?> infoDish(int id) async {
    try {
      final response = await _dio.get('info_dish', queryParameters: {"id": id});
      return InfoDishRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<InfoDishRes?> infoDish2(String name) async {
    try {
      final response = await _dio.get('info_dish2', queryParameters: {"name": name});
      return InfoDishRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<UpdateDishRes?> updateDish(int id, AddDishReq req) async {
    try {
      final response = await _dio.patch('update_dish', queryParameters: {"id": id}, data: req.toMap());
      return UpdateDishRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<UpdateIngredientRes?> updateIngredient(Ingredient req) async {
    try {
      final response = await _dio.patch('update_ingredient', data: req.toMap());
      return UpdateIngredientRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<GetRequiredIndexRes?> getRequiredIndexById(int id) async {
    try {
      final response = await _dio.get('required_index', queryParameters: {"id": id});
      return GetRequiredIndexRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<GetTotalWaterRes?> getTotalWater(GetTotalWaterReq req) async {
    try {
      final response = await _dio.get('total_water', queryParameters: req.toMap());
      return GetTotalWaterRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<InfoIngredientRes?> infoIngredient(int id) async {
    try {
      final response = await _dio.get('info_ingredient', queryParameters: {"id": id});
      return InfoIngredientRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<GetUserInfoRes?> getUserInfoById(int id) async {
    try {
      final response = await _dio.get('get_user_info', queryParameters: {"id": id});
      return GetUserInfoRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<GetNotificationsRes?> getNotificationsBySenderId(int id) async {
    try {
      final response = await _dio.get('get_notification', queryParameters: {"id": id});
      return GetNotificationsRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<UpdateStatusRes?> updateStatus(int id) async {
    try {
      final response = await _dio.patch('update_status', queryParameters: {"id": id});
      return UpdateStatusRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
