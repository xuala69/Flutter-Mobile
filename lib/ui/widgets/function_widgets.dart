import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'dialogs/error.dart';

void showLoader() {
  Get.dialog(const Center(child: CupertinoActivityIndicator()));
}

void showErrorDialog(String msg, String from) {
  log("Error coming from:$from");
  Future.delayed(const Duration(seconds: 1)).then((value) {
    Get.dialog(NetworkErrorDialog(
      errorMsg: msg,
    ));
  });
}
