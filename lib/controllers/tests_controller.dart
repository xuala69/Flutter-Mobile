import 'dart:developer';

import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/models/question_bank.dart';
import 'package:prep_pro/models/mock_test.dart';
import 'package:prep_pro/utils/strings.dart';
import '../ui/widgets/function_widgets.dart';
import 'get_storage_controller.dart';

class TestsController extends GetxController {
  TestsController get to => Get.find();
  final dio = DioController().to.dio;

  final recentTests = RxList<MockTest>([]);

  @override
  void onReady() {
    _getRecentTests();
    _listenRecentTests();
    getServerRecentTests();
    super.onReady();
  }

  _listenRecentTests() {
    GetStorageController().to.box.listenKey(LocalKeys.recentTests, (value) {
      if (value == null) {
        recentTests.value = [];
      } else {
        recentTests.clear();
        final List ls = value;
        for (var element in ls) {
          final model = MockTest.fromJson(element);
          recentTests.add(model);
        }
      }
    });
  }

  _getRecentTests() {
    final data = GetStorageController().to.box.read(LocalKeys.recentTests);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = MockTest.fromJson(element);
        recentTests.add(model);
      }
    }
  }

  Future<MockTest?> getTest(String slug) async {
    try {
      final res = await dio.get(
        Endpoints.mockTest + slug,
      );
      if (res.statusCode == 200) {
        final data = res.data;
        if (data != null) {
          final model = MockTest.fromJson(data);
          return model;
        }
        return null;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "getTest Single");
        return null;
      }
    } catch (e) {
      log("GET Error getTest ctrl:$e");
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
      log("GET Error initializeTest ctrl:$e");
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

  Future<bool> saveCheatDetected({
    required int cheatCount,
    required int testId,
    required int msSpent,
  }) async {
    try {
      //{{api_url}}/mock-test/{{mock-test-id}}/update-time
      final res = await dio.put(
        "${Endpoints.mockTest}$testId/update-time",
        data: {
          "block": cheatCount > 2,
          "total_time_spent": msSpent,
        },
      );
      if (res.statusCode == 200) {
        log("Saved  cheat detected to server: ");
        return true;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "saveCheatDetected");
        return false;
      }
    } catch (e) {
      final msg = e.toString();
      showErrorDialog(msg, "saveCheatDetected");
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

  Future<List<MockTest>?> getTests({
    required int pageNo,
    required Map<String, dynamic> filter,
  }) async {
    try {
      filter.putIfAbsent("page", () => pageNo);
      filter.putIfAbsent("type", () => "paginate");
      final res = await dio.get(Endpoints.mockTests, data: filter);
      if (res.statusCode == 200) {
        final List<MockTest> tests = [];
        final data = res.data['data'];
        if (data is List) {
          for (var element in data) {
            final model = MockTest.fromJson(element);
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

  void getServerRecentTests() async {
    try {
      final res = await dio.get(Endpoints.mockTests, data: {"type": "recent"});
      if (res.statusCode == 200) {
        final data = res.data;
        if (data is List) {
          for (var element in data) {
            final model = MockTest.fromJson(element);
            recentTests.add(model);
          }
        }
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "Recent tests");
        return null;
      }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg, "recentTests dummy");
      return null;
    }
  }
}
