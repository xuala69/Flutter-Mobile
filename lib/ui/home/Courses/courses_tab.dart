import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prep_pro/ui/home/Subjects/widgets/subjects_grid.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

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
    return Padding(
      padding: EdgeInsets.all(Nums.paddingNormal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PopularCoursesGrid(),
          vs(15),
          SubjectsGrid(),
        ],
      ),
    );
  }
}
