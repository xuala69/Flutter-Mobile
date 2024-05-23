import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/courses_controller.dart';

import 'carousel.dart';

class FeaturedCoursesGrid extends StatelessWidget {
  FeaturedCoursesGrid({super.key});
  final courseCtrl = CoursesController().to;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Featured Courses",
          style: GoogleFonts.spectral(
            fontSize: 18,
            color: Colors.grey[900],
          ),
          textAlign: TextAlign.start,
        ),
        Obx(
          () {
            if (courseCtrl.popularCourses.isEmpty) {
              return const Placeholder();
            } else {
              return CourseCarouselWidget(
                courses: courseCtrl.featuredCourses,
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
