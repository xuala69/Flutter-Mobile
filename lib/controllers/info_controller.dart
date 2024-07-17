import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/models/device_info.dart';
import 'package:prep_pro/ui/widgets/function_widgets.dart';
import 'package:prep_pro/utils/strings.dart';

import '../models/page.dart';

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

  Future<InfoPage?> getPage({required String slug}) async {
    try {
      final res = await DioController().to.get("${Endpoints.page}$slug", {});
      if (res != null) {
        final model = InfoPage.fromJson(res);
        return model;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "getPage");
        return null;
      }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg, "getPage");
      return null;
    }
  }
}
