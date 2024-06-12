import 'package:get/get.dart';
import 'package:prep_pro/controllers/exams_controller.dart';
import 'package:prep_pro/models/exams.dart';
import 'package:prep_pro/models/questions.dart';

class ExamDetailUIController extends GetxController {
  ExamDetailUIController get to => Get.find();

  final ctrl = ExamsController().to;
  final loading = true.obs;

  Rxn<Exam> exam = Rxn<Exam>();
  RxList<Question> questions = RxList();
  RxnInt currentStep = RxnInt();

  void getExam(String examId) async {
    final res = await Future.wait(
      [
        ctrl.getExam(examId),
        ctrl.getExamQuestions(examId),
      ],
    );
    exam.value = res[0] as Exam?;
    if (exam.value!.mode.toLowerCase() == "free") {
      //TODO lei tawh check la tih belh ngai
    }
    questions.value = res[1] as List<Question>;
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
