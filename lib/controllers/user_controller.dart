import 'package:get/get.dart';
import 'package:prep_pro/controllers/get_storage_controller.dart';
import 'package:prep_pro/models/users.dart';
import 'package:prep_pro/utils/strings.dart';

class UserController extends GetxController {
  UserController get to => Get.find();
  final user = Rx<User?>(null);

  @override
  void onReady() {
    _getUser();
    _listenUser();
    super.onReady();
  }

  _listenUser() {
    GetStorageController().to.box.listenKey(Strings.user, (value) {
      if (value == null) {
        user.value = null;
      } else {
        final model = User.fromJson(value);
        user.value = model;
      }
    });
  }

  _getUser() {
    final data = GetStorageController().to.box.read(Strings.user);
    if (data != null) {
      user.value = User.fromJson(data);
    }
  }
}
