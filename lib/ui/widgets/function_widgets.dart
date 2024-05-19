import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void showLoader() {
  Get.dialog(const Center(child: CupertinoActivityIndicator()));
}
