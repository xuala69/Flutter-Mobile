import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:prep_pro/controllers/tests_controller.dart';
import 'package:prep_pro/models/question_bank.dart';
import 'package:prep_pro/models/mock_test.dart';
import 'package:prep_pro/ui/home/MockTests/SingleTest/testing_page.dart';
import 'package:prep_pro/ui/widgets/dialogs/focus_lost_warning.dart';

class TestDetailUIController extends GetxController {
  TestDetailUIController get to => Get.find();

  final ctrl = TestsController().to;
  final loading = true.obs;
  final showExcerpt = true.obs;

  Rxn<MockTest> test = Rxn<MockTest>();
  Rxn<QuestionBank> questionBank = Rxn<QuestionBank>();
  RxnInt currentStep = RxnInt();
  RxInt warningCount = RxInt(0);
  RxnInt secRemaining = RxnInt();
  RxInt msUsed = RxInt(0);
  Timer? _timer;
  Timer? _msTimer;

  void startTest() async {
    loading.value = true;
    final bank = await ctrl.initializeTest(test.value!.slug);
    if (bank != null) {
      questionBank.value = bank;
      currentStep.value = 0;
      // maxTimeMs anih avangin 1000 a divide
      setTimer((questionBank.value!.maximumTimeMs) ~/ 1000);
      startTimer();
      loading.value = false;
      Get.to(() => const MockTestingPage());
    } else {
      log("InitializeTest failed and returned null");
    }
  }

  void getTest(String slug) async {
    final res = await ctrl.getTest(slug);
    test.value = res;
    if (test.value!.mode.toLowerCase() == "free") {
      //TODO lei tawh check la tih belh ngai
    }
    loading.value = false;
  }

  void setTimer(int newValue) {
    secRemaining.value = newValue;
    //TODO la check that leh ngai, continue vel atan?
    msUsed.value = 0;
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secRemaining.value != null && secRemaining.value! > 0) {
        secRemaining.value = secRemaining.value! - 1;
      }
    });
    _msTimer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      msUsed.value++;
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _msTimer?.cancel();
  }

  void saveAnswerNext(Option answerOption, {required bool isLast}) async {
    final success = await ctrl.saveTest(
      answerResponseId: questionBank.value!.responses[currentStep.value!].id,
      responseAns: answerOption.key,
      msSpent: msUsed.value,
    );
    if (isLast) {
      if (success) {
        ctrl.submitTest(mockTestId: test.value!.id);
        Get.back();
      }
    } else {
      if (success) {
        questionBank.value!.responses[currentStep.value!].answerResponse =
            answerOption.key;
        currentStep.value = currentStep.value! + 1;
      }
    }
  }

  void cheatDetected() {
    Future.delayed(const Duration(seconds: 1)).then(
      (data) {
        stopTimer();
        warningCount.value++;
        Get.dialog(
          FocusLostWarningDialog(
            message:
                "You have left the app ${warningCount.value} time. Your test will be blocked if you leave the app more than 3 times",
            testDuration: test.value!.testTime *
                60, // testTime hi hour in a awma minutes ah convert
            remainingSeconds: secRemaining.value!,
          ),
          barrierDismissible: false,
        );
        ctrl.saveCheatDetected(
          cheatCount: warningCount.value,
          testId: test.value!.id,
          msSpent: msUsed.value,
        );
      },
    );
  }

  // Future<List<Test>> fetchItemsFromApi(int page) async {
  //   // ignore: invalid_use_of_protected_member
  //   final sortMap = sortOptions.value;
  //   final data = await ctrl.getTests(pageNo: page, filter: {
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
