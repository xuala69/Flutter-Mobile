import 'dart:developer';

import 'package:get/get.dart';
import 'package:prep_pro/models/home_item.dart';
import 'package:prep_pro/ui/home/Course/SingleCoursePage/course_details_page.dart';
import 'package:prep_pro/ui/home/Tests/SingleTest/test_detail_page.dart';
import 'package:url_launcher/url_launcher_string.dart';

void homeItemClicked(Items item) {
  final type = (item.homeableType ?? "\\").split("\\").last;
  switch (type.toLowerCase()) {
    case "course":
      {
        Get.to(
          () => CourseDetailPage(
            courseId: item.homeableId!,
            courseSlug: "courseSlug",
          ),
        );
        break;
      }
    case "content":
      {
        //TODO content single page ngai
        Get.to(
          () => CourseDetailPage(
            courseId: item.homeableId!,
            courseSlug: "courseSlug",
          ),
        );
        break;
      }
    case "organization":
      {
        //TODO organization single page ngai
        Get.to(
          () => CourseDetailPage(
            courseId: item.homeableId!,
            courseSlug: "courseSlug",
          ),
        );
        break;
      }
    case "mock-test":
      {
        Get.to(
          () => TestDetailPage(
            testId: item.homeableId!,
            testSlug: "testSlug",
          ),
        );
        break;
      }
    case "subject":
      {
        //TODO Subject single page ngai
        Get.to(
          () => TestDetailPage(
            testId: item.homeableId!,
            testSlug: "subjectSlug",
          ),
        );
        break;
      }
    case "category":
      {
        //TODO Category single page ngai
        Get.to(
          () => TestDetailPage(
            testId: item.homeableId!,
            testSlug: "subjectSlug",
          ),
        );
        break;
      }
    default:
      {
        if (item.externalLink != null) {
          try {
            launchUrlString(item.externalLink!);
          } catch (e) {
            log("Error launching url : ${item.externalLink}");
          }
        }
      }
  }
}
