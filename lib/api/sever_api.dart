import 'package:al_datn_my_health/model/req/account_req.dart';
import 'package:al_datn_my_health/model/res/create_user_info_res.dart';
import 'package:al_datn_my_health/model/user_info.dart';
import 'package:dio/dio.dart';

import '../model/res/login_res.dart';
import '../model/res/register_res.dart';

class SeverApi {
  final Dio _dio;

  SeverApi()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'http://192.168.1.10:5000/',
          connectTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 10),
        ),
      );

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

  Future<CreateUserInfoRes?> createUserInfo(UserInfo req) async {
    try {
      final response = await _dio.post('create_userinfo', data: req.toMap());
      return CreateUserInfoRes.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
