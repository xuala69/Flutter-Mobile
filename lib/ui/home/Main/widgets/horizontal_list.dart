import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/courses_controller.dart';
import 'package:prep_pro/models/home_item.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';

class HorizontalList extends StatelessWidget {
  final HomeItem item;
  HorizontalList({required this.item, super.key});
  final courseCtrl = CoursesController().to;

  @override
  Widget build(BuildContext context) {
    if (courseCtrl.recentCourses.isEmpty) {
      return vs(0);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        vs(Nums.paddingNormal),
        if (item.caption != null)
          Text(
            item.caption!,
            style: GoogleFonts.spectral(
              fontSize: 18,
              color: Colors.grey[900],
            ),
            textAlign: TextAlign.start,
          ),
        SizedBox(
          height: Nums.horizontalItemHeight,
          child: ListView.separated(
            separatorBuilder: (data, index) {
              return hs(15);
            },
            itemCount: courseCtrl.recentCourses.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (data, index) {
              final item = courseCtrl.recentCourses[index];
              return Container(
                height: Nums.horizontalItemHeight,
                width: Nums.horizontalItemHeight,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      getImageUrl(item.imagePath),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
