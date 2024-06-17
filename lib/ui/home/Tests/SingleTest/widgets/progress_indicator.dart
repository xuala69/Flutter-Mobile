import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/datetime_functions.dart';
import 'package:prep_pro/utils/numbers_function.dart';
import 'package:prep_pro/utils/nums.dart';

import '../test_detail_ui_controller.dart';

class TestProgressIndicator extends StatelessWidget {
  TestProgressIndicator({super.key});
  final ctrl = TestDetailUIController().to;

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
                  "Question: ${ctrl.currentStep.value! + 1} of ${(ctrl.questions.length).toString()}",
                  style: GoogleFonts.spectral(
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.timer_outlined,
                ),
                hs(5),
                Obx(
                  () => Text(
                    DTFunctions().formatDuration(ctrl.secRemaining.value ?? 0),
                    style: GoogleFonts.spectral(
                      fontSize: 18,
                    ),
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
