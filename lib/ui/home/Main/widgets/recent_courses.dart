import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/courses_controller.dart';
import 'package:prep_pro/ui/home/Course/SingleCoursePage/course_details_page.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';

class RecentCourses extends StatelessWidget {
  RecentCourses({super.key});
  final ctrl = CoursesController().to;

  @override
  Widget build(BuildContext context) {
    if (ctrl.recentCourses.isEmpty) {
      return vs(0);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        vs(Nums.paddingNormal),
        Text(
          "Recently added Courses",
          style: GoogleFonts.spectral(
            fontSize: 18,
            color: Colors.grey[900],
          ),
          textAlign: TextAlign.start,
        ),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 0,
            crossAxisSpacing: Nums.paddingNormal,
          ),
          itemCount: ctrl.recentCourses.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final item = ctrl.recentCourses[index];
            return MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Get.to(
                  () => CourseDetailPage(
                    courseId: item.id,
                    courseSlug: item.slug,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      Nums.searchbarRadius,
                    ),
                  ),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      getImageUrl(item.imagePath),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
