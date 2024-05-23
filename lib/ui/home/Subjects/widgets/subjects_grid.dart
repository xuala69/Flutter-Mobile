import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/subjects_controller.dart';
import 'package:prep_pro/utils/color_functions.dart';
import 'package:prep_pro/utils/nums.dart';

class SubjectsGrid extends StatelessWidget {
  SubjectsGrid({super.key});
  final subjCtrl = SubjectsController().to;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Subjects",
          style: GoogleFonts.spectral(
            fontSize: 18,
            color: Colors.grey[900],
          ),
          textAlign: TextAlign.start,
        ),
        Obx(
          () {
            if (subjCtrl.subjects.isEmpty) {
              return const Placeholder();
            } else {
              return GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemCount: subjCtrl.subjects.length,
                itemBuilder: (context, index) {
                  final item = subjCtrl.subjects[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: cardColor(index),
                      borderRadius: BorderRadius.all(
                        Radius.circular(Nums.searchbarRadius),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        item.name,
                        style: GoogleFonts.spectral(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
