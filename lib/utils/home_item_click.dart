import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/ui/home/Course/Content/single_content_page.dart';
import 'package:prep_pro/ui/home/Course/SingleCoursePage/course_details_page.dart';
import 'package:prep_pro/ui/home/MockTests/SingleTest/test_detail_page.dart';

import '../models/home_item.dart';

Future<void> homeChildItemClick(BuildContext context, Items item) async {
  switch (item.homeableType.toString().toLowerCase()) {
    case "course":
      {
        Get.to(
          () => CourseDetailPage(
            courseId: item.homeableId!,
            courseSlug: item.homeable!.slug,
          ),
        );
        break;
      }
    case "content":
      {
        Get.to(
          () => SingleContentPage(
            contentSlug: item.homeable!.slug,
          ),
        );
        break;
      }
    case "mock test":
      {
        Get.to(
          () => TestDetailPage(
            testSlug: item.homeable!.slug,
            testId: item.homeableId!,
          ),
        );
        break;
      }
    case "subject":
      {
        // PersistentNavBarNavigator.pushNewScreen(
        //   context,
        //   screen: SingleCategoryPage(categoryId: item.linkId!),
        //   withNavBar: true,
        //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
        // );
        //TODO show subject details
        break;
      }
    // HomeLibrary
    case "category":
      {
        // Get.bottomSheet(
        //   MerchDetailSheet(merchId: item.linkId!),
        //   isScrollControlled: true,
        // );
        //TODO show category details
        break;
      }
    case "organization":
      {
        //TODO show organization details
        break;
      }

    default:
      {
        break;
      }
  }
}
