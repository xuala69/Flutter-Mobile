import 'dart:developer';

import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/models/question_bank.dart';
import 'package:prep_pro/models/test.dart';
import 'package:prep_pro/utils/strings.dart';
import '../ui/widgets/function_widgets.dart';
import 'get_storage_controller.dart';

class TestsController extends GetxController {
  TestsController get to => Get.find();
  final dio = DioController().to.dio;

  final popularTests = RxList<Test>([]);
  final featuredTests = RxList<Test>([]);

  @override
  void onReady() {
    _getPopularTests();
    _listenPopularTests();
    //server atangin app open ah fetch that a save zel, local ami zel hman tur
    getPopularTests();
    //Tests
    _getFeaturedTests();
    _listenFeaturedTests();
    //server atangin app open ah fetch that a save zel, local ami zel hman tur
    getFeaturedTests();
    super.onReady();
  }

  _listenPopularTests() {
    GetStorageController().to.box.listenKey(LocalKeys.subjects, (value) {
      if (value == null) {
        popularTests.value = [];
      } else {
        popularTests.clear();
        final List ls = value;
        for (var element in ls) {
          final model = Test.fromJson(element);
          popularTests.add(model);
        }
      }
    });
  }

  _getPopularTests() {
    final data = GetStorageController().to.box.read(
          LocalKeys.popularExams,
        );
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = Test.fromJson(element);
        popularTests.add(model);
      }
    }
  }

  _listenFeaturedTests() {
    GetStorageController().to.box.listenKey(LocalKeys.featuredExams, (value) {
      if (value == null) {
        featuredTests.value = [];
      } else {
        featuredTests.clear();
        final List ls = value;
        for (var element in ls) {
          final model = Test.fromJson(element);
          featuredTests.add(model);
        }
      }
    });
  }

  _getFeaturedTests() {
    final data = GetStorageController().to.box.read(LocalKeys.popularExams);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = Test.fromJson(element);
        featuredTests.add(model);
      }
    }
  }

  Future<Test?> getTest(String slug) async {
    try {
      final res = await dio.get(
        Endpoints.mockTest + slug,
      );
      if (res.statusCode == 200) {
        final data = res.data;
        if (data != null) {
          final model = Test.fromJson(data);
          return model;
        }
        return null;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "getTest Single");
        return null;
      }
    } catch (e) {
      log("GET Error exam ctrl:$e");
      final msg = e.toString();
      showErrorDialog(msg, "dummz");
      return null;
    }
  }

  Future<QuestionBank?> initializeTest(String examSlug) async {
    try {
      final res =
          await dio.post(Endpoints.initializeTest, data: {"slug": examSlug});
      if (res.statusCode == 200) {
        final data = res.data;
        if (data != null) {
          final model = QuestionBank.fromJson(data);
          return model;
        }
        return null;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "initializeTest");
        return null;
      }
    } catch (e) {
      log("GET Error exam ctrl:$e");
      final msg = e.toString();
      showErrorDialog(msg, "Initialize Test catch");
      return null;
    }
  }

  Future<bool> saveTest({
    required int answerResponseId,
    required String responseAns,
    required int msSpent,
  }) async {
    try {
      final res = await dio.put(
        Endpoints.saveResponse + answerResponseId.toString(),
        data: {
          "response": responseAns,
          "total_time_spent": msSpent,
        },
      );
      if (res.statusCode == 200) {
        log("Saved to server: ${answerResponseId.toString()} | $responseAns | $msSpent");
        return true;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "saveTest");
        return false;
      }
    } catch (e) {
      final msg = e.toString();
      showErrorDialog(msg, "saveTest");
      return false;
    }
  }

  ///{{api_url}}/mock-test/{{mock-test-id}}/submit

  Future<bool> submitTest({required int mockTestId}) async {
    try {
      final res = await dio.put(
        "${Endpoints.baseUrl}v1/mock-test/$mockTestId/submit",
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "submitTest");
        return false;
      }
    } catch (e) {
      final msg = e.toString();
      showErrorDialog(msg, "submitTest");
      return false;
    }
  }

  Future<List<Test>?> getTests({
    required int pageNo,
    required Map<String, dynamic> filter,
  }) async {
    try {
      filter.putIfAbsent("page", () => pageNo);
      filter.putIfAbsent("type", () => "paginate");
      final res = await dio.get(Endpoints.mockTests, data: filter);
      if (res.statusCode == 200) {
        final List<Test> tests = [];
        final data = res.data['data'];
        if (data is List) {
          for (var element in data) {
            final model = Test.fromJson(element);
            tests.add(model);
          }
        }
        return tests;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "Get Tests");
        return null;
      }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg, "DUmmy tests ctrl 2");
      return null;
    }
  }

  void getPopularTests() async {
    try {
      // final params = filter.putIfAbsent("page", () => pageNo);
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Strings.TestsUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Test> Tests = [
      //     Test(
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
      //     Test(
      //       id: "2",
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
      //     Test(
      //       id: "3",
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
      //       final model = Test.fromJson(element);
      //       Tests.add(model);
      //     }
      //   }
      //   return Tests;
      // } else {
      //   final msg = res.data['message'] ?? "Unknown error occured";
      //   showErrorDialog(msg);
      //   return null;
      // }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg, "getPopularTests dummy");
      return null;
    }
  }

  void getFeaturedTests() async {
    try {
      // log("Coming to get Featured Tests");
      // final data = [
      //   Test(
      //     id: 5,
      //     organizationId: 1,
      //     name: "NEET Mock Test | Zirlaite Puitu",
      //     slug: 'NEET',
      //     description: "NEET description",
      //     mode: "mode",
      //     contentsCount: 6,
      //     duration: 600,
      //     price: 1600.0,
      //     published: true,
      //     featured: true,
      //     imagePath: "https://picsum.photos/id/4/400/200",
      //     categoryId: 1,
      //     organization:
      //         Organization(id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //   ),
      //   Test(
      //     id: 3,
      //     organizationId: 1,
      //     name: "Class 12 Chemistry | Zawlbuk Zirna Run",
      //     slug: 'Class 12 Chemistry',
      //     description: "Class 12 Chemistry description",
      //     mode: "mode",
      //     contentsCount: 6,
      //     duration: 600,
      //     price: 1700.0,
      //     published: true,
      //     featured: true,
      //     imagePath: "https://picsum.photos/id/5/400/200",
      //     categoryId: 1,
      //     organization:
      //         Organization(id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //   ),
      //   Test(
      //     id: 1,
      //     organizationId: 1,
      //     name: "JEE Mock Test 3 | Chiko",
      //     slug: 'JEE',
      //     description: "JEE Mains description",
      //     mode: "mode",
      //     contentsCount: 6,
      //     duration: 600,
      //     price: 1500.0,
      //     published: true,
      //     featured: true,
      //     imagePath: "https://picsum.photos/id/6/400/200",
      //     categoryId: 1,
      //     organization: Organization(
      //       id: 1,
      //       name: "Chiko Tuition Centre",
      //       slug: "slug",
      //     ),
      //   ),
      // ];
      // GetStorageController().to.saveFeaturedTests(data);

      // final params = filter.putIfAbsent("page", () => pageNo);
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Strings.TestsUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Test> Tests = [
      //     Test(
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
      //     Test(
      //       id: "2",
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
      //     Test(
      //       id: "3",
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
      //       final model = Test.fromJson(element);
      //       Tests.add(model);
      //     }
      //   }
      //   return Tests;
      // } else {
      //   final msg = res.data['message'] ?? "Unknown error occured";
      //   showErrorDialog(msg);
      //   return null;
      // }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg, "getFeaturedTests dummy2");
      return null;
    }
  }
}
