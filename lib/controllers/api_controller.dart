import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/utils/strings.dart';

class ApiController extends GetxController {
  ApiController get to => Get.find();

  late Dio dio;

  @override
  void onInit() {
    dio = Dio(
      BaseOptions(
        baseUrl: Strings.baseUrl,
      ),
    );
    dio.options.headers = {};
    super.onInit();
  }

  Future<Map<String, dynamic>?> signInGoogle(Map<String, dynamic> data) async {
    try {
      final res = await dio.post(Strings.googleUrl, data: data);
      if (res.statusCode == 200) {
        var data = res.data;
        return data;
      } else {
        Future.delayed(const Duration(seconds: 1)).then((value) {
          Get.snackbar(
            "Authentication Error",
            res.statusCode.toString(),
            backgroundColor: Colors.red,
          );
        });
        var msg = res.data['message'];
        return {"message": msg ?? "Unknown error occured"};
      }
    } catch (e) {
      log("Error ApiController->signInGoogle$e");
      return {"message": "Unknown error occured"};
    }
  }

  Future<Map<String, dynamic>?> signInApple(Map<String, dynamic> data) async {
    try {
      final res = await dio.post(Strings.googleUrl, data: data);
      if (res.statusCode == 200) {
        var data = res.data;
        return data;
      } else {
        Future.delayed(const Duration(seconds: 1)).then((value) {
          Get.snackbar(
            "Authentication Error",
            res.statusCode.toString(),
            backgroundColor: Colors.red,
          );
        });
        var msg = res.data['message'];
        return {"message": msg ?? "Unknown error occured"};
      }
    } catch (e) {
      log("Error ApiController->signInGoogle$e");
      return {"message": "Unknown error occured"};
    }
  }
}
