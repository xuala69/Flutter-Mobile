import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/models/course.dart';
import 'package:prep_pro/ui/home/Course/SingleCoursePage/course_details_page.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';

class CourseListTile extends StatelessWidget {
  final Course course;
  const CourseListTile({required this.course, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Get.to(
          () => CourseDetailPage(
            courseId: course.id,
            courseSlug: course.slug,
          ),
        );
      },
      padding: EdgeInsets.zero,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Nums.paddingNormal),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]!,
            ),
            top: BorderSide(
              color: Colors.grey[300]!,
            ),
            left: BorderSide(
              color: Colors.grey[300]!,
            ),
            right: BorderSide(
              color: Colors.grey[300]!,
            ),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              Nums.searchbarRadius,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: Nums.avatarSize,
              height: Nums.avatarSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    Nums.searchbarRadius,
                  ),
                  bottomLeft: Radius.circular(
                    Nums.searchbarRadius,
                  ),
                ),
                color: Colors.grey[200],
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    getImageUrl(course.imagePath),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            hs(Nums.paddingNormal),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    course.name,
                    style: GoogleFonts.spectral(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    course.organization?.name ?? "",
                    style: GoogleFonts.spectral(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            hs(Nums.paddingNormal),
          ],
        ),
      ),
    );
  }
}
