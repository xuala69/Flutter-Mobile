import 'package:get/get.dart';
import 'package:prep_pro/models/test_history.dart';
import '../utils/strings.dart';
import 'get_storage_controller.dart';

class TestHistoryController extends GetxController {
  TestHistoryController get to => Get.find();

  final examHistories = RxList<TestHistory>([]);

  @override
  void onReady() {
    _getTestHistory();
    _listenTestHistory();
    super.onReady();
  }

  _listenTestHistory() {
    GetStorageController().to.box.listenKey(LocalKeys.examHistory, (value) {
      if (value == null) {
        examHistories.value = [];
      } else {
        examHistories.clear();
        final List ls = value;
        for (var element in ls) {
          final model = TestHistory.fromJson(element);
          examHistories.add(model);
        }
      }
    });
  }

  _getTestHistory() {
    final data = GetStorageController().to.box.read(LocalKeys.examHistory);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = TestHistory.fromJson(element);
        examHistories.add(model);
      }
    } else {
      // GetStorageController().to.saveTestHistory(
      //       TestHistory(
      //         id: 1,
      //         currentStep: 3,
      //         savedAt: DateTime.now(),
      //         exam: Test(
      //           id: 1,
      //           organizationId: 1,
      //           name: "JEE Mock Test",
      //           slug: "slug",
      //           description: "description",
      //           mode: "mode",
      //           questionsCount: 15,
      //           duration: 600,
      //           canBlock: true,
      //           price: 0,
      //           published: true,
      //           featured: true,
      //           categoryId: 1,
      //           organization: Organization(
      //             id: 1,
      //             name: "Chiko Tuition Centre",
      //             slug: "slug",
      //           ),
      //         ),
      //       ),
      //     );
    }
  }
}
