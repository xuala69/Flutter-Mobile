import 'dart:developer';

import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/models/content.dart';
import 'package:prep_pro/models/courses.dart';
import 'package:prep_pro/utils/strings.dart';
import '../ui/widgets/function_widgets.dart';

class ContentsController extends GetxController {
  ContentsController get to => Get.find();
  final dio = DioController().to.dio;

  Future<List<Content>?> getContents({required String courseId}) async {
    try {
      //TODO
      // final params = filter.putIfAbsent("page", () => pageNo);
      // final res = await dio.get(Endpoints.content);
      // if (res.statusCode == 200) {
      //   final List<Course> courses = [];
      //   final data = res.data['data'];
      //   if (data is List) {
      //     for (var element in data) {
      //       final model = Course.fromJson(element);
      //       courses.add(model);
      //     }
      //   }
      //   return courses;
      // } else {
      //   final msg = res.data['message'] ?? "Unknown error occured";
      //   showErrorDialog(msg);
      //   return null;
      // }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg);
      return null;
    }
    return null;
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
        courses;
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
      //TODO check that ngai ang
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
        courses;
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
