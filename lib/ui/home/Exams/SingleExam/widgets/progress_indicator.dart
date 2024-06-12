import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/numbers_function.dart';
import 'package:prep_pro/utils/nums.dart';

import '../exam_detail_ui_controller.dart';

class ExamProgressIndicator extends StatelessWidget {
  ExamProgressIndicator({super.key});
  final ctrl = ExamDetailUIController().to;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Nums.paddingNormal,
        vertical: Nums.paddingNormal,
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Question: ${ctrl.currentStep.value! + 1} of ${(ctrl.questions.length - 1).toString()}",
                  style: GoogleFonts.spectral(
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.timer_outlined,
                ),
                hs(5),
                Text(
                  "01:45",
                  style: GoogleFonts.spectral(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            vs(Nums.paddingNormal),
            LinearProgressIndicator(
              value: progressValue(
                currentValue: ctrl.currentStep.value!,
                length: ctrl.questions.length,
              ),
              minHeight: 10,
            ),
          ],
        ),
      ),
    );
  }
}
