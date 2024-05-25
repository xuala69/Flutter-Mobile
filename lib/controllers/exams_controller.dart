import 'dart:developer';

import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/models/exams.dart';
import 'package:prep_pro/models/organization.dart';
import 'package:prep_pro/utils/strings.dart';
import '../ui/widgets/function_widgets.dart';
import 'get_storage_controller.dart';

class ExamsController extends GetxController {
  ExamsController get to => Get.find();
  final dio = DioController().to.dio;

  final popularExams = RxList<Exam>([]);
  final featuredExams = RxList<Exam>([]);

  @override
  void onReady() {
    _getPopularExams();
    _listenPopularExams();
    //server atangin app open ah fetch that a save zel, local ami zel hman tur
    getPopularExams();
    //Exams
    _getFeaturedExams();
    _listenFeaturedExams();
    //server atangin app open ah fetch that a save zel, local ami zel hman tur
    getFeaturedExams();
    super.onReady();
  }

  _listenPopularExams() {
    GetStorageController().to.box.listenKey(LocalKeys.subjects, (value) {
      if (value == null) {
        popularExams.value = [];
      } else {
        popularExams.clear();
        final List ls = value;
        for (var element in ls) {
          final model = Exam.fromJson(element);
          popularExams.add(model);
        }
      }
    });
  }

  _getPopularExams() {
    final data = GetStorageController().to.box.read(LocalKeys.popularExams);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = Exam.fromJson(element);
        popularExams.add(model);
      }
    }
  }

  _listenFeaturedExams() {
    GetStorageController().to.box.listenKey(LocalKeys.featuredExams, (value) {
      if (value == null) {
        featuredExams.value = [];
      } else {
        featuredExams.clear();
        final List ls = value;
        for (var element in ls) {
          final model = Exam.fromJson(element);
          featuredExams.add(model);
        }
      }
    });
  }

  _getFeaturedExams() {
    final data = GetStorageController().to.box.read(LocalKeys.popularExams);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = Exam.fromJson(element);
        featuredExams.add(model);
      }
    }
  }

  Future<List<Exam>?> getExams({
    required int pageNo,
    required Map<String, dynamic> filter,
  }) async {
    try {
      log("Coming to get Exams");
      return [
        Exam(
          id: "1",
          organizationId: "1",
          name: "JEE Mock Test 1",
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
        Exam(
          id: "2",
          organizationId: "1",
          name: "NEET Mock Test 2",
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
        Exam(
          id: "3",
          organizationId: "1",
          name: "Class 12 Chemistry Mock Test",
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
      //   path: Strings.ExamsUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Exam> Exams = [
      //     Exam(
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
      //     Exam(
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
      //     Exam(
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
      //       final model = Exam.fromJson(element);
      //       Exams.add(model);
      //     }
      //   }
      //   return Exams;
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

  void getPopularExams() async {
    try {
      final data = [
        Exam(
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
        Exam(
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
        Exam(
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
      GetStorageController().to.savePopularExams(data);

      // final params = filter.putIfAbsent("page", () => pageNo);
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Strings.ExamsUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Exam> Exams = [
      //     Exam(
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
      //     Exam(
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
      //     Exam(
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
      //       final model = Exam.fromJson(element);
      //       Exams.add(model);
      //     }
      //   }
      //   return Exams;
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

  void getFeaturedExams() async {
    try {
      log("Coming to get Exams");
      final data = [
        Exam(
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
        Exam(
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
        Exam(
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
      GetStorageController().to.saveFeaturedExams(data);

      // final params = filter.putIfAbsent("page", () => pageNo);
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Strings.ExamsUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Exam> Exams = [
      //     Exam(
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
      //     Exam(
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
      //     Exam(
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
      //       final model = Exam.fromJson(element);
      //       Exams.add(model);
      //     }
      //   }
      //   return Exams;
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
