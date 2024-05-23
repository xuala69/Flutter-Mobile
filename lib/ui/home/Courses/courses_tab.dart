import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prep_pro/ui/home/Subjects/widgets/subjects_grid.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

import 'widgets/course_history.dart';
import 'widgets/featured_courses_grid.dart';
import 'widgets/popular_courses_grid.dart';

class HomeCoursesTab extends StatefulWidget {
  const HomeCoursesTab({super.key});

  @override
  State<HomeCoursesTab> createState() => _HomeCoursesTabState();
}

class _HomeCoursesTabState extends State<HomeCoursesTab> {
  @override
  void initState() {
    log("init called");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(Nums.paddingNormal),
      children: [
        FeaturedCoursesGrid(),
        vs(15),
        const CourseHistoryGrid(),
        vs(15),
        SubjectsGrid(),
        vs(15),
        PopularCoursesGrid(),
        vs(15),
      ],
    );
  }
}
