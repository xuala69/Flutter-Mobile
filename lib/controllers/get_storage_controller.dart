import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prep_pro/models/subjects.dart';
import 'package:prep_pro/models/users.dart';
import 'package:prep_pro/utils/strings.dart';

class GetStorageController extends GetxController {
  GetStorageController get to => Get.find();
  final box = GetStorage();

  void saveUser(User newData) {
    box.write(LocalKeys.user, newData.toJson());
  }

  void saveSubjects(List<Subject> newData) {
    box.write(LocalKeys.subjects, newData.map((e) => e.toJson()).toList());
  }
}
