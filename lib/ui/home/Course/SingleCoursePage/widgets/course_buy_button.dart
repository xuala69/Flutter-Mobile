import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/user_controller.dart';
import 'package:prep_pro/models/course.dart';
import 'package:prep_pro/ui/widgets/dialogs/confirm_course_order.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/course_content_functions.dart';
import 'package:prep_pro/utils/nums.dart';

class CourseBuyButton extends StatelessWidget {
  final Course course;
  CourseBuyButton({required this.course, super.key});

  final userCtrl = UserController().to;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isCoursePlayable(course)) {
        return MaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                Nums.searchbarRadius,
              ),
            ),
          ),
          color: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Start Learning",
            style: GoogleFonts.spectral(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }
      return MaterialButton(
        onPressed: () {
          Get.dialog(CourseOrderConfirmDialog(
            course: course,
          ));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Nums.searchbarRadius,
            ),
          ),
        ),
        color: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          "Buy Now",
          style: GoogleFonts.spectral(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
