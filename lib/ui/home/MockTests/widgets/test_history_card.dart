import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/test_history_controller.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/datetime_functions.dart';
import 'package:prep_pro/utils/nums.dart';

class TestHistoryGrid extends StatelessWidget {
  TestHistoryGrid({super.key});

  final examHistoryCtrl = Get.put(TestHistoryController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Ongoing Test",
          style: GoogleFonts.spectral(
            fontSize: 16,
          ),
          textAlign: TextAlign.left,
        ),
        vs(5),
        Obx(() {
          if (examHistoryCtrl.examHistories.isEmpty) {
            return vs(0);
          } else {
            return Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(
                  Radius.circular(Nums.searchbarRadius),
                ),
              ),
              padding: EdgeInsets.only(left: Nums.paddingNormal),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          examHistoryCtrl.examHistories.first.exam!.name,
                          style: GoogleFonts.spectral(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          examHistoryCtrl
                              .examHistories.first.exam!.organization!.name,
                          style: GoogleFonts.spectral(
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Opened: ${DTFunctions().savedAt(examHistoryCtrl.examHistories.first.savedAt)}",
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
