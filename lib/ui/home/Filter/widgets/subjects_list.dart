import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prep_pro/controllers/subjects_controller.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';

class SubjectsSheetList extends StatelessWidget {
  const SubjectsSheetList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        itemBuilder: (context, index) {
          final item = SubjectsController().to.subjects[index];
          return ListTile(
            onTap: () {
              item.isSelected = !item.isSelected;
              SubjectsController().to.subjects.refresh();
            },
            title: Text(
              item.name.replaceAll("   ", ""),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.spectral(
                fontSize: 14,
                color: item.isSelected ? Colors.blue[800] : Colors.grey[700],
              ),
            ),
            trailing: Icon(
              item.isSelected
                  ? MdiIcons.checkboxMarkedOutline
                  : MdiIcons.checkboxBlankOutline,
              color: item.isSelected ? Colors.blue[800] : Colors.grey[700],
              size: 20,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return vs(2);
        },
        itemCount: SubjectsController().to.subjects.length,
      ),
    );
  }
}