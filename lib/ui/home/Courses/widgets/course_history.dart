import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/course_history_controller.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/datetime_functions.dart';
import 'package:prep_pro/utils/nums.dart';

class CourseHistoryGrid extends StatelessWidget {
  CourseHistoryGrid({super.key});

  final courseHistoryCtrl = Get.put(CourseHistoryController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Ongoing Course",
          style: GoogleFonts.spectral(
            fontSize: 16,
          ),
          textAlign: TextAlign.left,
        ),
        vs(5),
        Obx(() {
          if (courseHistoryCtrl.courseHistories.isEmpty) {
            return vs(0);
          } else {
            return Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(
                  Radius.circular(Nums.searchbarRadius),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          courseHistoryCtrl.courseHistories.first.course!.name,
                          style: GoogleFonts.spectral(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          courseHistoryCtrl
                              .courseHistories.first.course!.organization!.name,
                          style: GoogleFonts.spectral(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Opened: ${DTFunctions().savedAt(courseHistoryCtrl.courseHistories.first.savedAt)}",
                          style: GoogleFonts.spectral(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: Text(
                        "CONTINUE",
                        style: GoogleFonts.spectral(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        }),
      ],
    );
  }
}
