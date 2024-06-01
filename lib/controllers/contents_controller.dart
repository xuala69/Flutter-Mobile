import 'dart:developer';

import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/models/content.dart';
import 'package:prep_pro/models/courses.dart';
import 'package:prep_pro/models/organization.dart';
import 'package:prep_pro/utils/strings.dart';
import '../ui/widgets/function_widgets.dart';
import 'get_storage_controller.dart';

class ContentsController extends GetxController {
  ContentsController get to => Get.find();
  final dio = DioController().to.dio;

  Future<List<Content>?> getContents({required String courseId}) async {
    try {
      log("Coming to get Courses");
      final data = [
        Content(
          id: "1",
          courseId: "1",
          name: "Flutter for beginners: Setting up the environment",
          slug: "slug",
          type: "Pdf",
          mode: "Free",
          duration: 60,
          price: 1000,
          published: true,
          filePath: Strings.pdfLink,
        ),
        Content(
          id: "2",
          courseId: "1",
          name: "Flutter for beginners: Creating your first project",
          slug: "slug",
          type: "Video_link",
          mode: "Free",
          duration: 60,
          price: 1000,
          videoLink: Strings.videoLink,
          published: true,
        ),
        Content(
          id: "3",
          courseId: "1",
          name: "Flutter for beginners: What is widget?",
          slug: "slug",
          type: "Text",
          mode: "Free",
          duration: 60,
          content: sampleTextContent,
          price: 1000,
          published: true,
        ),
      ];
      return data;
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
          createdAt: DateTime.now().toIso8601String(),
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
          createdAt: DateTime.now().toIso8601String(),
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
          createdAt: DateTime.now().toIso8601String(),
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
          createdAt: DateTime.now().toIso8601String(),
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
          createdAt: DateTime.now().toIso8601String(),
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
          createdAt: DateTime.now().toIso8601String(),
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
      return Course(
        id: id,
        organizationId: "1",
        name: "Flutter for beginners",
        slug: "flutter-for-beginners",
        description: "Flutter for beginners, from scratch to production",
        mode: "Free",
        contentsCount: 2,
        duration: 30,
        price: 1000,
        createdAt: DateTime.now().toIso8601String(),
        published: true,
        featured: true,
        categoryId: "1",
      );
      // final res = await dio.getUri(
      //   Uri(
      //     scheme: 'https',
      //     host: 'api.onepercent.com',
      //     path: "${Strings.coursesUrl}/$id",
      //     // queryParameters: params,
      //   ),
      // );
      // if (res.statusCode == 200) {
      //   final data = res.data['data'];
      //   final model = Course.fromJson(data);
      //   return model;
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
}
