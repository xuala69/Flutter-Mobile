import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/datetime_functions.dart';
import 'package:prep_pro/utils/nums.dart';

import '../test_detail_ui_controller.dart';

class TestIntroSummary extends StatelessWidget {
  TestIntroSummary({super.key});
  final ctrl = TestDetailUIController().to;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Material(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(
              Nums.searchbarRadius,
            ),
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                vs(5),
                Text(
                  ctrl.test.value?.name ?? "",
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
                      ctrl.test.value?.organization?.name ?? "N/A",
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
                      ctrl.test.value?.category?.name ?? "N/A",
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
                      // Test model test time hi minutes ania, function in seconds a expect sia 60 a multiply a ni
                      DTFunctions()
                          .formatDuration(ctrl.test.value!.testTime * 60),
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
                    Text("${ctrl.test.value!.questionsCount} Questions"),
                  ],
                ),
                vs(25),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: SingleChildScrollView(
                    child: HtmlWidget(
                      ctrl.test.value?.description ?? "",
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
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
