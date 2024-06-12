import 'dart:developer';

import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/models/courses.dart';
import 'package:prep_pro/utils/strings.dart';
import '../ui/widgets/function_widgets.dart';
import 'get_storage_controller.dart';

class CoursesController extends GetxController {
  CoursesController get to => Get.find();
  final dio = DioController().to.dio;

  final popularCourses = RxList<Course>([]);
  final featuredCourses = RxList<Course>([]);

  final courses = RxList<Course>([]);

  @override
  void onReady() {
    _getPopularCourses();
    _listenPopularCourses();
    //server atangin app open ah fetch that a save zel, local ami zel hman tur
    getPopularCourses();
    //courses
    _getFeaturedCourses();
    _listenFeaturedCourses();
    //server atangin app open ah fetch that a save zel, local ami zel hman tur
    getFeaturedCourses();
    super.onReady();
  }

  _listenPopularCourses() {
    GetStorageController().to.box.listenKey(LocalKeys.subjects, (value) {
      if (value == null) {
        popularCourses.value = [];
      } else {
        popularCourses.clear();
        final List ls = value;
        for (var element in ls) {
          final model = Course.fromJson(element);
          popularCourses.add(model);
        }
      }
    });
  }

  _getPopularCourses() {
    final data = GetStorageController().to.box.read(LocalKeys.popularCourses);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = Course.fromJson(element);
        popularCourses.add(model);
      }
    }
  }

  _listenFeaturedCourses() {
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

  _getFeaturedCourses() {
    final data = GetStorageController().to.box.read(LocalKeys.popularCourses);
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
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Endpoints.courses,
      //   queryParameters: params,
      // ));
      if (res.statusCode == 200) {
        final data = res.data['data'];
        if (data is List) {
          for (var element in data) {
            final model = Course.fromJson(element);
            courses.add(model);
          }
        }
        return courses;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg);
        return null;
      }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg);
      return null;
    }
  }

  void getPopularCourses() async {
    try {
      final res = await dio.get(Endpoints.courses, data: {"type": "popular"});
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
        showErrorDialog(msg);
        return null;
      }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg);
      return null;
    }
  }

  void getFeaturedCourses() async {
    try {
      //TODO check that ngai
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
        showErrorDialog(msg);
        return null;
      }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg);
      return null;
    }
  }
  //sampleCourseJs

  Future<Course?> getCourse({required String slug}) async {
    try {
      final res = await dio.get("${Endpoints.course}$slug");
      if (res.statusCode == 200) {
        final data = res.data['data'];
        final model = Course.fromJson(data);
        return model;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg);
        return null;
      }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg);
      return null;
    }
  }
}
