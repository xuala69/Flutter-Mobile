import 'package:get/get.dart';
import 'package:prep_pro/models/exam_history.dart';
import 'package:prep_pro/models/exams.dart';
import 'package:prep_pro/models/organization.dart';
import '../utils/strings.dart';
import 'get_storage_controller.dart';

class ExamHistoryController extends GetxController {
  ExamHistoryController get to => Get.find();

  final examHistories = RxList<ExamHistory>([]);

  @override
  void onReady() {
    _getExamHistory();
    _listenExamHistory();
    super.onReady();
  }

  _listenExamHistory() {
    GetStorageController().to.box.listenKey(LocalKeys.examHistory, (value) {
      if (value == null) {
        examHistories.value = [];
      } else {
        examHistories.clear();
        final List ls = value;
        for (var element in ls) {
          final model = ExamHistory.fromJson(element);
          examHistories.add(model);
        }
      }
    });
  }

  _getExamHistory() {
    final data = GetStorageController().to.box.read(LocalKeys.examHistory);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = ExamHistory.fromJson(element);
        examHistories.add(model);
      }
    } else {
      GetStorageController().to.saveExamHistory(
            ExamHistory(
              id: "1",
              currentStep: 3,
              savedAt: DateTime.now(),
              exam: Exam(
                id: "1",
                organizationId: "1",
                name: "JEE Mock Test",
                slug: "slug",
                description: "description",
                mode: "mode",
                contentsCount: 15,
                duration: 600,
                price: 0,
                published: true,
                featured: true,
                categoryId: "1",
                organization: Organization(
                  id: "1",
                  name: "Chiko Tuition Centre",
                  slug: "slug",
                ),
              ),
            ),
          );
    }
  }
}
