import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/courses_controller.dart';
import 'package:prep_pro/controllers/exams_controller.dart';
import 'package:prep_pro/ui/home/Filter/filter_ui_controller.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/nums.dart';

class FilterSheet extends StatelessWidget {
  final Function(dynamic) onSubmit;
  FilterSheet({required this.onSubmit, super.key});

  final examsCtrl = ExamsController().to;
  final coursesCtrl = CoursesController().to;

  final uiCtrl = Get.put(FilterUIController());

  final double fontSize = 14;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                Nums.searchbarRadius,
              ),
              topRight: Radius.circular(
                Nums.searchbarRadius,
              ),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              filterHeader(),
              const Divider(
                height: 1,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: filterCategoriesList(),
                    ),
                    Expanded(
                      flex: 7,
                      child: Obx(
                        () => uiCtrl.getFilterUI(),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey[200],
              ),
              vs(5),
              filterFooter(),
              vs(5),
              Divider(
                height: 1,
                color: Colors.grey[200],
              ),
              vs(25)
            ],
          ),
        ),
      ),
    );
  }

  Widget filterCategoriesList() {
    return Container(
      padding: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: uiCtrl.filterCategories.map((e) {
          return Obx(
            () => Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              child: ListTile(
                onTap: () {
                  uiCtrl.changeCategory(e);
                },
                tileColor: uiCtrl.isSelected(e),
                contentPadding: const EdgeInsets.only(left: 5),
                title: Text(
                  e,
                  style: GoogleFonts.spectral(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget filterFooter() {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          hs(Nums.paddingNormal),
          MaterialButton(
            onPressed: () {
              uiCtrl.clearFilter();
            },
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.all(Radius.circular(
                  Nums.searchbarRadius,
                ))),
            child: Text(
              "Clear Filters",
              style: GoogleFonts.spectral(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          const Spacer(),
          MaterialButton(
            onPressed: () {
              onSubmit(uiCtrl.submitSort());
              Get.back();
            },
            color: AppColors.primary,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Nums.searchbarRadius,
                ),
              ),
            ),
            child: Text(
              "Show Results",
              style: GoogleFonts.spectral(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          hs(Nums.paddingNormal),
        ],
      ),
    );
  }

  Widget filterHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      height: 50,
      child: Row(
        children: [
          hs(Nums.paddingNormal),
          Text(
            "Filters",
            style: GoogleFonts.spectral(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Close",
              style: GoogleFonts.spectral(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          hs(Nums.paddingNormal),
        ],
      ),
    );
  }
}
