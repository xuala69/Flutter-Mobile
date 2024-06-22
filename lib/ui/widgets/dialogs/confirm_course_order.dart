import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/payment_controller.dart';
import 'package:prep_pro/models/course.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

class CourseOrderConfirmDialog extends StatelessWidget {
  final Course course;
  const CourseOrderConfirmDialog({required this.course, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Nums.paddingNormal,
            vertical: Nums.paddingNormal,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "What you'll get",
                style: GoogleFonts.spectral(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: SingleChildScrollView(
                  child: HtmlWidget(
                    course.description,
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              vs(15),
              vs(5),
              Text(
                course.name,
                style: GoogleFonts.spectral(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      onPressed: () {
                        Get.back();
                        final pay = Get.put(PaymentController());
                        pay.buyCourse(course: course, payableId: course.id);
                      },
                      child: const Text("OKAY"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
