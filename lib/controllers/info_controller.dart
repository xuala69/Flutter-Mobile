import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:prep_pro/models/device_info.dart';

class InfoController extends GetxController {
  InfoController get to => Get.find();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Rxn<PhoneInfo> info = Rxn<PhoneInfo>();

  RxList<String> sortOptions = [
    "Featured",
    "Price:High to Low",
    "Price:Low to High",
    "Latest",
  ].obs;

  RxString selectedSortOption = "".obs;

  @override
  void onReady() {
    getDeviceInfo();
    selectedSortOption.value = sortOptions.first;
    super.onReady();
  }

  void getDeviceInfo() {
    if (Platform.isAndroid) {
      deviceInfo.androidInfo.then((value) {
        log(value.toString());
        info.value = PhoneInfo(
          id: value.id,
          name: value.model,
          version: "Android ${value.version}",
          isAndroid: true,
        );
      });
    }
    if (Platform.isIOS) {
      deviceInfo.iosInfo.then((value) {
        info.value = PhoneInfo(
          id: value.identifierForVendor.toString(),
          name: value.name,
          version: "${value.systemName} ${value.systemVersion}",
          isAndroid: false,
        );
      });
    }
  }
}
