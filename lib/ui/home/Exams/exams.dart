import 'package:flutter/material.dart';
import 'package:prep_pro/ui/home/Subjects/widgets/subjects_grid.dart';
import 'package:prep_pro/utils/nums.dart';

class HomeExamsPage extends StatefulWidget {
  const HomeExamsPage({super.key});

  @override
  State<HomeExamsPage> createState() => _HomeExamsPageState();
}

class _HomeExamsPageState extends State<HomeExamsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Nums.paddingNormal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubjectsGrid(),
        ],
      ),
    );
  }
}
