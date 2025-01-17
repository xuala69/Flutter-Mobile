import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/models/question_bank.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/nums.dart';

import '../test_detail_ui_controller.dart';

class OptionsCard extends StatelessWidget {
  final QuestionResponses questionResponse;
  OptionsCard({required this.questionResponse, super.key});
  final ctrl = TestDetailUIController().to;
  final Rxn<Option> selectedOption = Rxn<Option>();

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
    for (var element in questionResponse.question.options) {
      opts.add(
        Obx(
          () => ListTile(
            onTap: () {
              selectedOption.value = element;
            },
            leading: Icon(
              selectedOption.value?.key == element.key
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
            ),
            title: Text(element.key),
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
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Nums.searchbarRadius,
                ),
              ),
            ),
            onPressed: () {
              if (selectedOption.value == null) {
                Fluttertoast.showToast(
                  msg: "Please select an answer",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                return;
              }
              ctrl.saveAnswerNext(
                selectedOption.value!,
                isLast: ctrl.currentStep.value ==
                    (ctrl.questionBank.value!.responses.length - 1),
              );
            },
            child: Text(
              ctrl.currentStep.value ==
                      (ctrl.questionBank.value!.responses.length - 1)
                  ? "SAVE AND SUBMIT"
                  : "SAVE AND NEXT",
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
