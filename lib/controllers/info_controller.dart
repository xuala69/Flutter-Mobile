import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:prep_pro/models/device_info.dart';

class InfoController extends GetxController {
  InfoController get to => Get.find();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Rxn<PhoneInfo> info = Rxn<PhoneInfo>();

  @override
  void onReady() {
    getDeviceInfo();
    super.onReady();
  }

  void getDeviceInfo() {
    deviceInfo.androidInfo.then((value) {
      log(value.toString());
      info.value = PhoneInfo(
        id: value.id,
        name: value.model,
        version: "Android ${value.version}",
        isAndroid: true,
      );
    });
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
