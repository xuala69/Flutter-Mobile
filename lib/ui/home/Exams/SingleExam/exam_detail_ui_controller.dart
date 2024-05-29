import 'package:get/get.dart';
import 'package:prep_pro/controllers/exams_controller.dart';
import 'package:prep_pro/models/exams.dart';

class ExamDetailUIController extends GetxController {
  final ctrl = ExamsController().to;
  final loading = true.obs;

  Rxn<Exam> exam = Rxn<Exam>();

  void getExam(String examId) async {
    final data = await ctrl.getExam(examId);
    exam.value = data;
    loading.value = false;
  }

  // Future<List<Exam>> fetchItemsFromApi(int page) async {
  //   // ignore: invalid_use_of_protected_member
  //   final sortMap = sortOptions.value;
  //   final data = await ctrl.getExams(pageNo: page, filter: {
  //     "search": searchText.value,
  //     "category_ids": sortMap['categories'],
  //     "subject_ids": sortMap['subjects'],
  //     "organization_ids": sortMap['organizations'],
  //     "sort": sortMap['sort'],
  //   });
  //   log("Returned value from api with search:${searchText.value} $data");
  //   return data ?? [];
  // }

  @override
  void dispose() {
    // pagingController.dispose();
    super.dispose();
  }
}
