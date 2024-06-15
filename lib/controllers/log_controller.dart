import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide FormData;
import 'package:prep_pro/utils/strings.dart';

import 'get_storage_controller.dart';

class LogController extends GetxController {
  final dio = Dio();
  final storage = GetStorageController().to;

  void dLog(String content) async {
    try {
      final name = storage.getUser()?.name ?? "N/A";
      final id = storage.getUser()?.id ?? "N/A";
      FormData formData = FormData.fromMap(
        {
          "username": "Bug report from $id - $name ",
          "content": content,
        },
      );
      var res = await dio.post(
        Endpoints.discord,
        data: formData,
      );
      log("Discord POST success ${res.statusCode}");
    } catch (e) {
      log("send  POST discord error $e");
    }
  }
}

void dLog(String data) {
  if (!kDebugMode) {
    Get.find<LogController>().dLog(data);
  }
}
