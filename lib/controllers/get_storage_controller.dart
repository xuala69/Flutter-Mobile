import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prep_pro/models/category.dart';
import 'package:prep_pro/models/course_history.dart';
import 'package:prep_pro/models/course.dart';
import 'package:prep_pro/models/test_history.dart';
import 'package:prep_pro/models/test.dart';
import 'package:prep_pro/models/organization.dart';
import 'package:prep_pro/models/subject.dart';
import 'package:prep_pro/models/user.dart';
import 'package:prep_pro/utils/strings.dart';

class GetStorageController extends GetxController {
  GetStorageController get to => Get.find();
  final box = GetStorage();

  void saveUser(User newData) {
    box.write(LocalKeys.user, newData.toJson());
  }

  User? getUser() {
    final js = box.read(LocalKeys.user);
    if (js != null && js != "") {
      User user = User.fromJson(js);
      return user;
    }
    return null;
  }

  void saveToken(String token) {
    box.write(LocalKeys.userToken, token);
  }

  String getToken() {
    return box.read(LocalKeys.userToken) ?? "";
  }

  void saveSubjects(List<Subject> newData) {
    // box.write(LocalKeys.subjects, newData.map((e) => e.toJson()).toList());
  }

  void savePopularCourses(List<Course> newData) {
    // box.write(
    //     LocalKeys.popularCourses, newData.map((e) => e.toJson()).toList());
  }

  void saveFeaturedCourses(List<Course> newData) {
    // box.write(
    //     LocalKeys.featuredCourses, newData.map((e) => e.toJson()).toList());
  }

  void saveCourseHistory(CourseHistory newData) {
    // final data = box.read(LocalKeys.courseHistory);
    // final List<CourseHistory> tempList = [];
    // if (data != null && data is List) {
    //   for (var element in data) {
    //     CourseHistory model = CourseHistory.fromJson(element);
    //     tempList.insert(0, model);
    //   }
    //   tempList.insert(0, newData);
    // } else {
    //   tempList.add(newData);
    // }
    // box.write(
    //     LocalKeys.courseHistory, tempList.map((e) => e.toJson()).toList());
  }

  void savePopularTests(List<Test> newData) {
    // box.write(LocalKeys.popularTests, newData.map((e) => e.toJson()).toList());
  }

  void saveFeaturedTests(List<Test> newData) {
    // box.write(LocalKeys.featuredTests, newData.map((e) => e.toJson()).toList());
  }

  void saveTestHistory(TestHistory newData) {
    // final data = box.read(LocalKeys.examHistory);
    // final List<TestHistory> tempList = [];
    // if (data != null && data is List) {
    //   for (var element in data) {
    //     TestHistory model = TestHistory.fromJson(element);
    //     tempList.insert(0, model);
    //   }
    //   tempList.insert(0, newData);
    // } else {
    //   tempList.add(newData);
    // }
    // box.write(LocalKeys.examHistory, tempList.map((e) => e.toJson()).toList());
  }

  void saveAllCategories(List<Category> newData) {
    // box.write(LocalKeys.categories, newData.map((e) => e.toJson()).toList());
  }

  void saveAllOrganizations(List<Organization> newData) {
    // box.write(LocalKeys.organizations, newData.map((e) => e.toJson()).toList());
  }

  void saveHomeItems(String data) {
    box.write(LocalKeys.homeItems, data);
  }

  String getHomeItems() {
    return box.read(LocalKeys.homeItems) ?? "";
  }
}
