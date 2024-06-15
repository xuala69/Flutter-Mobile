import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/exams_controller.dart';
import 'package:prep_pro/ui/home/Tests/widgets/exams_carouse.dart';

class PopularTestsGrid extends StatelessWidget {
  PopularTestsGrid({super.key});
  final examsController = TestsController().to;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Popular Tests",
          style: GoogleFonts.spectral(
            fontSize: 18,
            color: Colors.grey[900],
          ),
          textAlign: TextAlign.start,
        ),
        Obx(
          () {
            if (examsController.popularTests.isEmpty) {
              return const Placeholder();
            } else {
              return TestsCarouselWidget(
                exams: examsController.popularTests,
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
