import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/exams_controller.dart';
import 'package:prep_pro/ui/home/Exams/widgets/exams_carouse.dart';

class PopularExamsGrid extends StatelessWidget {
  PopularExamsGrid({super.key});
  final examsController = ExamsController().to;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Popular Exams",
          style: GoogleFonts.spectral(
            fontSize: 18,
            color: Colors.grey[900],
          ),
          textAlign: TextAlign.start,
        ),
        Obx(
          () {
            if (examsController.popularExams.isEmpty) {
              return const Placeholder();
            } else {
              return ExamsCarouselWidget(
                exams: examsController.popularExams,
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
