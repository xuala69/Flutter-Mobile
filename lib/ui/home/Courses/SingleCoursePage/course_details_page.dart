import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/ui/widgets/m_appbar.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'course_detail_ui_controller.dart';

class CourseDetailPage extends StatelessWidget {
  final String courseId;
  CourseDetailPage({required this.courseId, super.key});
  final uiCtrl = Get.put(CourseDetailUIController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mAppbar(),
      body: Obx(
        () => uiCtrl.loading.isTrue
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : ui(),
      ),
    );
  }

  Widget ui() {
    return ListView(
      children: [
        Text(
          uiCtrl.course.value!.name,
          style: GoogleFonts.spectral(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            Text(
              uiCtrl.course.value?.organization?.name ?? "N/A",
              style: GoogleFonts.spectral(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // Html(
        //   data: course.description,
        //   shrinkWrap: true,
        // )
        HtmlWidget(
          uiCtrl.course.value?.description ?? "",
        )
      ],
    );
  }
}
