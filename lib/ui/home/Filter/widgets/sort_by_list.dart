import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/ui/home/Filter/filter_ui_controller.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';

class SortOptionsSheetList extends StatelessWidget {
  SortOptionsSheetList({super.key});

  final ctrl = FilterUIController().to;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        itemBuilder: (context, index) {
          final item = ctrl.sortOptions[index];
          return ListTile(
            onTap: () {
              ctrl.changeSortOption(item);
              ctrl.sortOptions.refresh();
            },
            title: Text(
              item,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.spectral(
                fontSize: 14,
                color:
                    ctrl.isSortSelected(item) ? Colors.blue[700] : Colors.black,
              ),
            ),
            trailing: Icon(
              ctrl.isSortSelected(item)
                  ? Icons.radio_button_checked_sharp
                  : Icons.radio_button_unchecked_sharp,
              color: ctrl.isSortSelected(item)
                  ? Colors.blue[800]
                  : Colors.grey[700],
              size: 20,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return vs(2);
        },
        itemCount: ctrl.sortOptions.length,
      ),
    );
  }
}
