import 'dart:developer';

import 'package:get/get.dart';
import 'package:prep_pro/models/subject.dart';

import '../ui/widgets/function_widgets.dart';
import '../utils/strings.dart';
import 'get_storage_controller.dart';

class SubjectsController extends GetxController {
  SubjectsController get to => Get.find();

  final subjects = RxList<Subject>([]);

  @override
  void onReady() {
    _getSubjects();
    _listenSubjects();
    //server atangin app open ah fetch that a save zel, local ami zel hman tur
    getAllSubjects();
    super.onReady();
  }

  _listenSubjects() {
    GetStorageController().to.box.listenKey(LocalKeys.subjects, (value) {
      if (value == null) {
        subjects.value = [];
      } else {
        subjects.clear();
        final List ls = value;
        for (var element in ls) {
          final model = Subject.fromJson(element);
          subjects.add(model);
        }
      }
    });
  }

  _getSubjects() {
    final data = GetStorageController().to.box.read(LocalKeys.subjects);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = Subject.fromJson(element);
        subjects.add(model);
      }
    }
  }

  void getAllSubjects() async {
    try {
      final data = [
        Subject(
          id: 1,
          name: "Mathematics",
          slug: "mathematics",
          description: "description",
          contentsCount: 22,
          published: true,
          featured: true,
        ),
        Subject(
          id: 2,
          name: "Physics",
          slug: "physics",
          description: "description",
          contentsCount: 8,
          published: true,
          featured: true,
        ),
        Subject(
          id: 3,
          name: "Chemistry",
          slug: "chemistry",
          description: "description",
          contentsCount: 12,
          published: true,
          featured: true,
        ),
        Subject(
          id: 4,
          name: "Biology",
          slug: "biology",
          description: "description",
          contentsCount: 18,
          published: true,
          featured: true,
        ),
        Subject(
          id: 5,
          name: "History",
          slug: "history",
          description: "description",
          contentsCount: 11,
          published: true,
          featured: true,
        ),
      ];
      GetStorageController().to.saveSubjects(data);
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
      //       id: 1,
      //       organizationId: 1,
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
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Course(
      //       id: 2,
      //       organizationId: 1,
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
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Course(
      //       id: 3,
      //       organizationId: 1,
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
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
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
      showErrorDialog(msg, "dummmgg");
      return null;
    }
  }
}
