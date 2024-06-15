import 'package:flutter/material.dart';
import 'package:prep_pro/ui/home/Main/widgets/exam_history_card.dart';
import 'package:prep_pro/ui/home/Main/widgets/featured_exams.dart';
import 'package:prep_pro/ui/home/Subjects/widgets/subjects_grid.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

import '../Courses/widgets/course_history.dart';
import '../Courses/widgets/featured_courses_grid.dart';
import '../Courses/widgets/popular_courses_grid.dart';
import '../Tests/widgets/popular_exams_card.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(Nums.paddingNormal),
      children: [
        FeaturedTestsGrid(),
        vs(15),
        TestHistoryGrid(),
        vs(15),
        SubjectsGrid(),
        vs(15),
        PopularTestsGrid(),
        vs(15),
        FeaturedCoursesGrid(),
        vs(15),
        CourseHistoryGrid(),
        vs(15),
        PopularCoursesGrid(),
        vs(105),
      ],
    );
  }
}
