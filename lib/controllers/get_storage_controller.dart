import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prep_pro/models/users.dart';

class GetStorageController extends GetxController {
  GetStorageController get to => Get.find();
  final box = GetStorage();

  void saveUser(User newData) {
    box.write("user", newData.toJson());
  }
}
