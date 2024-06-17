import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/datetime_functions.dart';
import 'package:prep_pro/utils/nums.dart';

import '../exam_detail_ui_controller.dart';

class TestIntroSummary extends StatelessWidget {
  TestIntroSummary({super.key});
  final ctrl = TestDetailUIController().to;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                vs(5),
                Text(
                  ctrl.exam.value?.name ?? "",
                  style: GoogleFonts.spectral(
                    fontSize: 25,
                  ),
                ),
                vs(5),
                Row(
                  children: [
                    Icon(
                      MdiIcons.officeBuilding,
                      size: 25,
                    ),
                    hs(10),
                    Text(
                      ctrl.exam.value?.organization?.name ?? "N/A",
                    ),
                  ],
                ),
                vs(5),
                Row(
                  children: [
                    Icon(
                      MdiIcons.certificateOutline,
                    ),
                    hs(10),
                    Text(
                      ctrl.exam.value?.category?.name ?? "N/A",
                    ),
                  ],
                ),
                vs(5),
                Row(
                  children: [
                    Icon(
                      MdiIcons.timerOutline,
                    ),
                    hs(10),
                    Text(
                      DTFunctions().formatDuration(ctrl.exam.value!.duration),
                    ),
                  ],
                ),
                vs(5),
                Row(
                  children: [
                    Icon(
                      MdiIcons.folderQuestion,
                    ),
                    hs(10),
                    Text("${ctrl.exam.value!.questionsCount} Questions"),
                  ],
                ),
                vs(25),
                HtmlWidget(
                  ctrl.exam.value?.description ?? "",
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                vs(15),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    onPressed: () {
                      Get.back(result: true);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Nums.searchbarRadius,
                        ),
                      ),
                    ),
                    color: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 45),
                    child: Text(
                      "Start Test",
                      style: GoogleFonts.spectral(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                vs(10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
