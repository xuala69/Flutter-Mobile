import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/ui/widgets/m_appbar.dart';
import 'test_detail_ui_controller.dart';
import 'widgets/options_card.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

import 'widgets/progress_indicator.dart';

class MockTestingPage extends StatefulWidget {
  const MockTestingPage({super.key});

  @override
  State<MockTestingPage> createState() => _MockTestingPageState();
}

class _MockTestingPageState extends State<MockTestingPage>
    with WidgetsBindingObserver {
  final uiCtrl = Get.find<TestDetailUIController>();
  RxBool showWarning = false.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        log("inactive");
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.resumed:
        log("App is resumed");
        // notification en pawn a detect vang in a tawk mai hmel a , edge case a awm tak leh la ngaihtuah that leh ah
        uiCtrl.cheatDetected();
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mAppbar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TestProgressIndicator(),
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(
                      left: Nums.paddingNormal,
                      right: Nums.paddingNormal,
                    ),
                    child: HtmlWidget(
                      uiCtrl.questionBank.value!
                          .responses[uiCtrl.currentStep.value!].question.name,
                      textStyle: GoogleFonts.spectral(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                vs(MediaQuery.of(context).size.height * 0.3)
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(
              () => uiCtrl.currentStep.value == null
                  ? hs(0)
                  : OptionsCard(
                      questionResponse: uiCtrl.questionBank.value!
                          .responses[uiCtrl.currentStep.value!],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
