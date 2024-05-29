import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/courses_controller.dart';
import 'package:prep_pro/models/courses.dart';

class CourseDetailsPage extends StatelessWidget {
  final String courseId;
  const CourseDetailsPage({required this.courseId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<Course?>(
          future: CoursesController().to.getCourseById(courseId),
          builder: (context, snap) {
            if (snap.hasData) {
              final data = snap.data;
              if (data != null) {
                return courseDetails(data);
              }
              return const Center(
                child: Text("Unknown error. Please try again"),
              );
            }
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }),
    );
  }

  Widget courseDetails(Course course) {
    return ListView(
      children: [
        Text(
          course.name,
          style: GoogleFonts.spectral(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            Text(
              course.organization?.name ?? "N/A",
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
          course.description,
        )
      ],
    );
  }
}
