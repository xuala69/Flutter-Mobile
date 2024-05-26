import 'dart:developer';

import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/models/category.dart';
import 'package:prep_pro/utils/strings.dart';
import '../ui/widgets/function_widgets.dart';
import 'get_storage_controller.dart';

class CategoriesController extends GetxController {
  CategoriesController get to => Get.find();
  final dio = DioController().to.dio;

  final categories = RxList<Category>([]);

  @override
  void onReady() {
    _getAllCategories();
    _listenCategories();
    //server atangin app open ah fetch that a save zel, local ami zel hman tur
    getCategoriesFromServer();
    super.onReady();
  }

  _listenCategories() {
    GetStorageController().to.box.listenKey(LocalKeys.categories, (value) {
      if (value == null) {
        categories.value = [];
      } else {
        categories.clear();
        final List ls = value;
        for (var element in ls) {
          final model = Category.fromJson(element);
          categories.add(model);
        }
      }
    });
  }

  _getAllCategories() {
    final data = GetStorageController().to.box.read(LocalKeys.categories);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = Category.fromJson(element);
        categories.add(model);
      }
    }
  }

  void getCategoriesFromServer() async {
    try {
      final data = [
        Category(
          id: "1",
          name: "CUET PG",
          slug: "cuet-pg",
        ),
        Category(
          id: "2",
          name: "Civil Services",
          slug: "cuet-pg",
        ),
        Category(
          id: "3",
          name: "Computer Engineering",
          slug: "cuet-pg",
        ),
        Category(
          id: "4",
          name: "UPSC",
          slug: "cuet-pg",
        ),
      ];
      GetStorageController().to.saveAllCategories(data);

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
}
