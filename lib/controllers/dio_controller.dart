import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/controllers/get_storage_controller.dart';
import 'package:prep_pro/utils/strings.dart';

import '../ui/widgets/dialogs/error.dart';

class DioController extends GetxController {
  DioController get to => Get.find();

  late Dio dio;

  @override
  void onInit() {
    dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
      ),
    );
    dio.options.headers = {
      "Authorization": "Bearer ${GetStorageController().to.getToken()}"
    };
    super.onInit();
  }

  Future<Map<String, dynamic>?> signInGoogle(Map<String, dynamic> data) async {
    try {
      final res = await dio.post(Endpoints.googleUrl, data: data);
      if (res.statusCode == 200) {
        var data = res.data;
        final token = data['token'];
        GetStorageController().to.saveToken(token);
        dio.options.headers = {
          "Authorization": "Bearer ${GetStorageController().to.getToken()}"
        };
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
      log("Error DioController->signInGoogle$e");
      return {"message": "Unknown error occured"};
    }
  }

  Future<Map<String, dynamic>?> signInApple(Map<String, dynamic> data) async {
    try {
      final res = await dio.post(Endpoints.googleUrl, data: data);
      if (res.statusCode == 200) {
        var data = res.data;
        final token = data['token'];
        GetStorageController().to.saveToken(token);
        dio.options.headers = {
          "Authorization": "Bearer ${GetStorageController().to.getToken()}"
        };
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
      log("Error DioController->signInGoogle$e");
      return {"message": "Unknown error occured"};
    }
  }

  Future<Map<String, dynamic>?> signInEmailPw() async {
    try {
      final res = await dio.post(Endpoints.emailpw, data: {
        "platform": "test",
      });
      if (res.statusCode == 200) {
        var data = res.data;
        final token = data['token'];
        GetStorageController().to.saveToken(token);
        dio.options.headers = {
          "Authorization": "Bearer ${GetStorageController().to.getToken()}"
        };
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
      log("Error DioController->signInGoogle$e");
      return {"message": "Unknown error occured"};
    }
  }

  Future<dynamic> get(String path, Map<String, dynamic> data) async {
    try {
      final res = await dio.getUri(Uri(
        scheme: 'https',
        host: 'api.themoviedb.org',
        path: path,
        queryParameters: data,
      ));
      if (res.statusCode == 200) {
        return res.data;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        log("Error1: $msg");
        Future.delayed(const Duration(seconds: 1)).then((value) {
          Get.dialog(NetworkErrorDialog(
            errorMsg: msg,
          ));
        });
        return null;
      }
    } catch (e) {
      log("GET Error2:$e");
      final msg = e.toString();
      log("Error2: $msg");
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Get.dialog(NetworkErrorDialog(
          errorMsg: msg,
        ));
      });
      return null;
    }
  }

  Future<dynamic> post(String path, Map<String, dynamic> data) async {
    try {
      final res = await dio.post(path, data: data);
      if (res.statusCode == 200) {
        return res.data;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        log("Error posting data on dioController(): $msg");
        Future.delayed(const Duration(seconds: 1)).then((value) {
          Get.dialog(NetworkErrorDialog(
            errorMsg: msg,
          ));
        });
        return null;
      }
    } catch (e) {
      log("GET Error2 posting data on dioController():$e");
      final msg = e.toString();
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Get.dialog(NetworkErrorDialog(
          errorMsg: msg,
        ));
      });
      return null;
    }
  }

  Future<dynamic> delete(String uri) async {
    log("DELETE: $uri");
    return dio.delete(uri);
  }
}
