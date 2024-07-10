import 'dart:developer';

import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/models/course.dart';
import 'package:prep_pro/utils/strings.dart';
import '../ui/widgets/function_widgets.dart';
import 'get_storage_controller.dart';

class CoursesController extends GetxController {
  CoursesController get to => Get.find();
  final dio = DioController().to.dio;

  final recentCourses = RxList<Course>([]);
  final featuredCourses = RxList<Course>([]);

  final courses = RxList<Course>([]);

  @override
  void onReady() {
    _getServerRecentCourses();
    _getRecentCourses();
    _listenRecentCourses();
    //server atangin app open ah fetch that a save zel, local ami zel hman tur
    // featured hichu server ah kan la nei chiahloa dah tawp rih
    // getServerFeaturedCourses();
    // getFeaturedCourses();
    // listenFeaturedCourses();
    super.onReady();
  }

  _listenRecentCourses() {
    GetStorageController().to.box.listenKey(LocalKeys.recentCourses, (value) {
      if (value == null) {
        recentCourses.value = [];
      } else {
        recentCourses.clear();
        final List ls = value;
        for (var element in ls) {
          final model = Course.fromJson(element);
          recentCourses.add(model);
        }
      }
    });
  }

  _getRecentCourses() {
    final data = GetStorageController().to.box.read(LocalKeys.recentCourses);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = Course.fromJson(element);
        recentCourses.add(model);
      }
    }
  }

  listenFeaturedCourses() {
    GetStorageController().to.box.listenKey(LocalKeys.featuredCourses, (value) {
      if (value == null) {
        featuredCourses.value = [];
      } else {
        featuredCourses.clear();
        final List ls = value;
        for (var element in ls) {
          final model = Course.fromJson(element);
          featuredCourses.add(model);
        }
      }
    });
  }

  getFeaturedCourses() {
    final data = GetStorageController().to.box.read(LocalKeys.featuredCourses);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = Course.fromJson(element);
        featuredCourses.add(model);
      }
    }
  }

  Future<List<Course>?> getCourses({
    required int pageNo,
    required Map<String, dynamic> filter,
  }) async {
    try {
      filter.putIfAbsent("type", () => "paginate");
      final res = await dio.get(
        Endpoints.courses,
        data: filter,
      );
      if (res.statusCode == 200) {
        final List<Course> localCourses = [];
        final data = res.data['data'];
        if (data is List) {
          for (var element in data) {
            final model = Course.fromJson(element);
            localCourses.add(model);
          }
        }
        return localCourses;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "getCourses1");
        return null;
      }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg, "getCourses2");
      return null;
    }
  }

  void _getServerRecentCourses() async {
    try {
      final res = await dio.get(Endpoints.courses, data: {"type": "recent"});
      if (res.statusCode == 200) {
        final data = res.data;
        if (data is List) {
          for (var element in data) {
            final model = Course.fromJson(element);
            recentCourses.add(model);
          }
        }
        log("Server recent courses :$recentCourses");
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "recentCourses");
        return null;
      }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg, "recentCourses");
      return null;
    }
  }

  void getServerFeaturedCourses() async {
    try {
      final res = await dio.get(Endpoints.courses, data: {"type": "featured"});
      if (res.statusCode == 200) {
        final List<Course> courses = [];
        final data = res.data['data'];
        if (data is List) {
          for (var element in data) {
            final model = Course.fromJson(element);
            courses.add(model);
          }
        }
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "getFeaturedCourses");
        return null;
      }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg, "getFeaturedCourses");
      return null;
    }
  }
  //sampleCourseJs

  Future<Course?> getCourse({required String slug}) async {
    try {
      final res = await dio.get("${Endpoints.course}$slug");
      if (res.statusCode == 200) {
        final data = res.data;
        final model = Course.fromJson(data);
        return model;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "getCourse");
        return null;
      }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg, "getCourse");
      return null;
    }
  }
}
