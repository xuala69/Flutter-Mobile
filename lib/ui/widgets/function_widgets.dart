import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'dialogs/error.dart';

void showLoader() {
  Get.dialog(const Center(child: CupertinoActivityIndicator()));
}

void showErrorDialog(String msg) {
  Future.delayed(const Duration(seconds: 1)).then((value) {
    Get.dialog(NetworkErrorDialog(
      errorMsg: msg,
    ));
  });
}
