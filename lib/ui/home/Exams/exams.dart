import 'package:flutter/material.dart';
import 'package:prep_pro/ui/home/Exams/widgets/exam_history_card.dart';
import 'package:prep_pro/ui/home/Exams/widgets/featured_exams.dart';
import 'package:prep_pro/ui/home/Subjects/widgets/subjects_grid.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

import 'widgets/popular_exams_card.dart';

class HomeExamsPage extends StatefulWidget {
  const HomeExamsPage({super.key});

  @override
  State<HomeExamsPage> createState() => _HomeExamsPageState();
}

class _HomeExamsPageState extends State<HomeExamsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(Nums.paddingNormal),
      children: [
        FeaturedExamsGrid(),
        vs(15),
        ExamHistoryGrid(),
        vs(15),
        SubjectsGrid(),
        vs(15),
        PopularExamsGrid(),
        vs(105),
      ],
    );
  }
}
