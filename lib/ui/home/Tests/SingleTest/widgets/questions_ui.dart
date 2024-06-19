import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/ui/home/Tests/SingleTest/test_detail_ui_controller.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

import 'options_card.dart';
import 'progress_indicator.dart';

class QuestionsUI extends StatelessWidget {
  QuestionsUI({super.key});
  final uiCtrl = Get.find<TestDetailUIController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
