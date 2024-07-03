import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/controllers/get_storage_controller.dart';
import 'package:prep_pro/models/user.dart';
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

  void refreshUserData() async {
    final url = Endpoints.user;
    final res = await DioController().to.get(
      url,
      {},
    );
    if (res != null) {
      final data = User.fromJson(res);
      user.value = data;
      GetStorageController().to.saveUser(data);
    }
  }

  bool canAccessCourse({required int id}) {
    for (var course in user.value!.activeCourses) {
      if (course.payableId == id) {
        return true;
      }
    }
    return false;
  }

  bool canAccessContent({required int id}) {
    for (var content in user.value!.activeContents) {
      if (content.payableId == id) {
        return true;
      }
    }
    return false;
  }

  bool canAccessMockTest({required int id}) {
    for (var test in user.value!.activeMockTests) {
      if (test.payableId == id) {
        return true;
      }
    }
    return false;
  }

  _listenUser() {
    GetStorageController().to.box.listenKey(LocalKeys.user, (value) {
      if (value == null) {
        user.value = null;
      } else {
        final model = User.fromJson(value);
        user.value = model;
      }
    });
  }

  _getUser() {
    final data = GetStorageController().to.box.read(LocalKeys.user);
    if (data != null) {
      user.value = User.fromJson(data);
    }
  }
}
