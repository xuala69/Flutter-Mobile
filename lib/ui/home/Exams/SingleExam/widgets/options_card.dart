import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/models/questions.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/nums.dart';

import '../exam_detail_ui_controller.dart';

class OptionsCard extends StatelessWidget {
  final Question question;
  OptionsCard({required this.question, super.key});
  final ctrl = ExamDetailUIController().to;
  final RxnString selectedKey = RxnString();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Nums.searchbarRadius),
          topRight: Radius.circular(Nums.searchbarRadius),
        ),
      ),
      margin: EdgeInsets.only(
        bottom: Nums.paddingHigh,
      ),
      padding: EdgeInsets.only(
        left: Nums.paddingNormal,
        right: Nums.paddingNormal,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _options(),
      ),
    );
  }

  List<Widget> _options() {
    List<Widget> opts = [];
    for (var element in question.options) {
      opts.add(
        Obx(
          () => ListTile(
            onTap: () {
              selectedKey.value = element.key;
            },
            leading: Icon(
              selectedKey.value == element.key
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
            ),
            title: Text(element.value),
          ),
        ),
      );
    }
    opts.add(_saveNextBtn());
    return opts;
  }

  Widget _saveNextBtn() {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 15),
            color: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(
              Nums.searchbarRadius,
            ))),
            onPressed: () {},
            child: Text(
              "SAVE AND NEXT",
              style: GoogleFonts.spectral(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
