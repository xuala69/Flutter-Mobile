import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/exams_controller.dart';
import 'package:prep_pro/ui/home/Exams/widgets/exams_carouse.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';

class FeaturedExamsGrid extends StatelessWidget {
  FeaturedExamsGrid({super.key});
  final examsCtrl = ExamsController().to;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Featured Exams",
          style: GoogleFonts.spectral(
            fontSize: 18,
            color: Colors.grey[900],
          ),
          textAlign: TextAlign.start,
        ),
        Obx(
          () {
            if (examsCtrl.featuredExams.isEmpty) {
              return vs(0);
            } else {
              return ExamsCarouselWidget(
                exams: examsCtrl.featuredExams,
                onTap: (p0) {
                  //TODO goto new page
                },
              );
            }
          },
        ),
      ],
    );
  }
}
