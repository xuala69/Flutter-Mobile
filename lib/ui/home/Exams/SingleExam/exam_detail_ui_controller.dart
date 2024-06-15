import 'dart:async';

import 'package:get/get.dart';
import 'package:prep_pro/controllers/exams_controller.dart';
import 'package:prep_pro/models/exams.dart';
import 'package:prep_pro/models/questions.dart';

class ExamDetailUIController extends GetxController {
  ExamDetailUIController get to => Get.find();

  final ctrl = ExamsController().to;
  final loading = true.obs;
  final showExcerpt = true.obs;

  Rxn<Exam> exam = Rxn<Exam>();
  RxList<Question> questions = RxList();
  RxnInt currentStep = RxnInt();
  RxnInt secRemaining = RxnInt();
  Timer? _timer;

  void getExam(int examId) async {
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

  void setTimer(int newValue) {
    secRemaining.value = newValue;
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secRemaining.value != null && secRemaining.value! > 0) {
        secRemaining.value = secRemaining.value! - 1;
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void saveAnswerNext(Option answerOption) {
    questions[currentStep.value!].answer = answerOption;
    currentStep.value = currentStep.value! + 1;
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
