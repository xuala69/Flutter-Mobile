import 'package:get/get.dart';

class InfoController extends GetxController {
  InfoController get to => Get.find();

  @override
  void onReady() {
    getDeviceInfo();
    super.onReady();
  }

  void getDeviceInfo() {}
}
