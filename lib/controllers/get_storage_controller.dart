import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prep_pro/models/course_history.dart';
import 'package:prep_pro/models/courses.dart';
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

  void savePopularCourses(List<Course> newData) {
    box.write(
        LocalKeys.popularCourses, newData.map((e) => e.toJson()).toList());
  }

  void saveFeaturedCourses(List<Course> newData) {
    box.write(
        LocalKeys.featuredCourses, newData.map((e) => e.toJson()).toList());
  }

  void saveCourseHistory(CourseHistory newData) {
    final data = box.read(LocalKeys.courseHistory);
    final List<CourseHistory> tempList = [];
    if (data != null && data is List) {
      for (var element in data) {
        CourseHistory model = CourseHistory.fromJson(element);
        tempList.insert(0, model);
      }
      tempList.insert(0, newData);
    } else {
      tempList.add(newData);
    }
    box.write(
        LocalKeys.courseHistory, tempList.map((e) => e.toJson()).toList());
  }
}
