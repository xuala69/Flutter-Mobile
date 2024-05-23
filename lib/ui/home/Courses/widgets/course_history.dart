import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/utils/nums.dart';

class CourseHistoryGrid extends StatelessWidget {
  const CourseHistoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(
          Radius.circular(Nums.searchbarRadius),
        ),
      ),
      child: Text(
        "Continue where you left off?",
        style: GoogleFonts.spectral(
          fontSize: 16,
        ),
      ),
    );
  }
}
