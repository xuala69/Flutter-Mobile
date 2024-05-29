import 'dart:developer';

import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/models/courses.dart';
import 'package:prep_pro/models/organization.dart';
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
      log("Coming to get Courses");
      return [
        Course(
          id: "1",
          organizationId: "1",
          name: "Chiko | JEE",
          slug: 'JEE',
          description: "JEE Mains description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1500.0,
          published: true,
          featured: true,
          imagePath: null,
          categoryId: "1",
          organization: Organization(
            id: "1",
            name: "Chiko Tuition Centre",
            slug: "slug",
          ),
        ),
        Course(
          id: "2",
          organizationId: "1",
          name: "Chiko | NEET",
          slug: 'NEET',
          description: "NEET description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1600.0,
          published: true,
          featured: true,
          imagePath: null,
          categoryId: "1",
          organization:
              Organization(id: "1", name: "Chiko Tuition Centre", slug: "slug"),
        ),
        Course(
          id: "3",
          organizationId: "1",
          name: "Chiko | Class 12 Chemistry",
          slug: 'Class 12 Chemistry',
          description: "Class 12 Chemistry description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1700.0,
          published: true,
          featured: true,
          imagePath: null,
          categoryId: "1",
          organization:
              Organization(id: "1", name: "Chiko Tuition Centre", slug: "slug"),
        ),
      ];
      // final params = filter.putIfAbsent("page", () => pageNo);
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Strings.coursesUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Course> courses = [
      //     Course(
      //       id: "1",
      //       organizationId: "1",
      //       name: "Chiko | JEE",
      //       slug: 'JEE',
      //       description: "JEE Mains description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1500.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: "1",
      //       organization: Organization(
      //           id: "1", name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Course(
      //       id: "2",
      //       organizationId: "1",
      //       name: "Chiko | NEET",
      //       slug: 'NEET',
      //       description: "NEET description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1600.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: "1",
      //       organization: Organization(
      //           id: "1", name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Course(
      //       id: "3",
      //       organizationId: "1",
      //       name: "Chiko | Class 12 Chemistry",
      //       slug: 'Class 12 Chemistry',
      //       description: "Class 12 Chemistry description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1700.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: "1",
      //       organization: Organization(
      //           id: "1", name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //   ];
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
  }

  void getPopularCourses() async {
    try {
      final data = [
        Course(
          id: "1",
          organizationId: "1",
          name: "Chiko | JEE",
          slug: 'JEE',
          description: "JEE Mains description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1500.0,
          published: true,
          featured: true,
          imagePath: "https://picsum.photos/id/1/400/200",
          categoryId: "1",
          organization: Organization(
            id: "1",
            name: "Chiko Tuition Centre",
            slug: "slug",
          ),
        ),
        Course(
          id: "2",
          organizationId: "1",
          name: "Chiko | NEET",
          slug: 'NEET',
          description: "NEET description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1600.0,
          published: true,
          featured: true,
          imagePath: "https://picsum.photos/id/2/400/200",
          categoryId: "1",
          organization:
              Organization(id: "1", name: "Chiko Tuition Centre", slug: "slug"),
        ),
        Course(
          id: "3",
          organizationId: "1",
          name: "Chiko | Class 12 Chemistry",
          slug: 'Class 12 Chemistry',
          description: "Class 12 Chemistry description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1700.0,
          published: true,
          featured: true,
          imagePath: "https://picsum.photos/id/3/400/200",
          categoryId: "1",
          organization:
              Organization(id: "1", name: "Chiko Tuition Centre", slug: "slug"),
        ),
      ];
      GetStorageController().to.savePopularCourses(data);

      // final params = filter.putIfAbsent("page", () => pageNo);
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Strings.coursesUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Course> courses = [
      //     Course(
      //       id: "1",
      //       organizationId: "1",
      //       name: "Chiko | JEE",
      //       slug: 'JEE',
      //       description: "JEE Mains description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1500.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: "1",
      //       organization: Organization(
      //           id: "1", name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Course(
      //       id: "2",
      //       organizationId: "1",
      //       name: "Chiko | NEET",
      //       slug: 'NEET',
      //       description: "NEET description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1600.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: "1",
      //       organization: Organization(
      //           id: "1", name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Course(
      //       id: "3",
      //       organizationId: "1",
      //       name: "Chiko | Class 12 Chemistry",
      //       slug: 'Class 12 Chemistry',
      //       description: "Class 12 Chemistry description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1700.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: "1",
      //       organization: Organization(
      //           id: "1", name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //   ];
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
  }

  void getFeaturedCourses() async {
    try {
      log("Coming to get Courses");
      final data = [
        Course(
          id: "5",
          organizationId: "1",
          name: "Zirlaite Puitu | NEET",
          slug: 'NEET',
          description: "NEET description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1600.0,
          published: true,
          featured: true,
          imagePath: "https://picsum.photos/id/4/400/200",
          categoryId: "1",
          organization:
              Organization(id: "1", name: "Chiko Tuition Centre", slug: "slug"),
        ),
        Course(
          id: "3",
          organizationId: "1",
          name: "Zawlbuk Zirna Run | Class 12 Chemistry",
          slug: 'Class 12 Chemistry',
          description: "Class 12 Chemistry description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1700.0,
          published: true,
          featured: true,
          imagePath: "https://picsum.photos/id/5/400/200",
          categoryId: "1",
          organization:
              Organization(id: "1", name: "Chiko Tuition Centre", slug: "slug"),
        ),
        Course(
          id: "1",
          organizationId: "1",
          name: "Chiko | JEE",
          slug: 'JEE',
          description: "JEE Mains description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1500.0,
          published: true,
          featured: true,
          imagePath: "https://picsum.photos/id/6/400/200",
          categoryId: "1",
          organization: Organization(
            id: "1",
            name: "Chiko Tuition Centre",
            slug: "slug",
          ),
        ),
      ];
      GetStorageController().to.saveFeaturedCourses(data);

      // final params = filter.putIfAbsent("page", () => pageNo);
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Strings.coursesUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Course> courses = [
      //     Course(
      //       id: "1",
      //       organizationId: "1",
      //       name: "Chiko | JEE",
      //       slug: 'JEE',
      //       description: "JEE Mains description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1500.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: "1",
      //       organization: Organization(
      //           id: "1", name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Course(
      //       id: "2",
      //       organizationId: "1",
      //       name: "Chiko | NEET",
      //       slug: 'NEET',
      //       description: "NEET description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1600.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: "1",
      //       organization: Organization(
      //           id: "1", name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Course(
      //       id: "3",
      //       organizationId: "1",
      //       name: "Chiko | Class 12 Chemistry",
      //       slug: 'Class 12 Chemistry',
      //       description: "Class 12 Chemistry description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1700.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: "1",
      //       organization: Organization(
      //           id: "1", name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //   ];
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
  }
  //sampleCourseJs

  Future<Course?> getCourse(String id) async {
    try {
      final res = await dio.getUri(
        Uri(
          scheme: 'https',
          host: 'api.onepercent.com',
          path: "${Strings.coursesUrl}/$id",
          // queryParameters: params,
        ),
      );
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
