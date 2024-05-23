import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prep_pro/models/courses.dart';
import 'package:prep_pro/utils/nums.dart';

class CourseListTile extends StatelessWidget {
  final Course course;
  const CourseListTile({required this.course, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: course.imagePath != null
          ? Container(
              width: Nums.tileImage,
              height: Nums.tileImage,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(course.imagePath!),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(Nums.searchbarRadius),
                ),
                color: Colors.grey[200],
              ),
            )
          : Container(
              width: Nums.tileImage,
              height: Nums.tileImage,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(
                  Radius.circular(Nums.searchbarRadius),
                ),
              ),
              child: Center(
                child: Icon(
                  MdiIcons.octagramMinusOutline,
                ),
              ),
            ),
      title: Text(course.name),
      subtitle: Text(course.organization?.name ?? "N/A"),
    );
  }
}
