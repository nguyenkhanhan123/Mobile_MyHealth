import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:al_datn_my_health/model/req/chat_req.dart';
import 'package:al_datn_my_health/model/req/get_meal_plan_req.dart';
import 'package:al_datn_my_health/model/req/replace_meal_req.dart';
import 'package:al_datn_my_health/model/res/get_meal_plan_res.dart';
import '../model/res/replace_meal_res.dart';
import 'package:http/http.dart' as http;

class AiApi {
  final Dio _dio;

  AiApi()
      : _dio = Dio(
    BaseOptions(
      baseUrl: 'https://truglpk3-datn-fastapi.hf.space/',
      connectTimeout: Duration(seconds: 120),
      receiveTimeout: Duration(seconds: 120),
    ),
  );

  Stream<String> chatAI(ChatReq req) async* {
    try {
      final client = http.Client();
      final request = http.Request('POST', Uri.parse('https://truglpk3-datn-fastapi.hf.space/chat/'));

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';

      request.body = jsonEncode(req.toMap());

      final response = await client.send(request);

      if (response.statusCode == 200) {
        await for (var chunk in response.stream.transform(utf8.decoder)) {
          yield chunk;
        }

      } else {
        yield "Lỗi Server: ${response.statusCode}";
      }

      client.close();

    } catch (e) {
      print("Lỗi Stream: $e");
      yield " [Lỗi kết nối]";
    }
  }

  Future<GetMealPlanRes?> getMealPlan(GetMealPlanReq req) async {
    try {
      final response = await _dio.post('meal-plan/', data: req.toMap());
      var data=GetMealPlanRes.fromJson(response.data);
      print(data.toJson());
      return GetMealPlanRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<ReplaceMealRes?> swapMeal(ReplaceMealReq req) async {
    try {
      print(req.toMap());
      final response = await _dio.post('food-replace/', data: req.toMap());
      return ReplaceMealRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}