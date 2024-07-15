import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/ui/home/Tests/SingleTest/test_detail_ui_controller.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/datetime_functions.dart';
import 'package:prep_pro/utils/nums.dart';

class FocusLostWarningDialog extends StatelessWidget {
  final String message;
  final int testDuration;
  final int remainingSeconds;
  const FocusLostWarningDialog(
      {required this.testDuration,
      required this.remainingSeconds,
      required this.message,
      super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
          backgroundColor: Colors.grey[200],
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Nums.paddingNormal,
              vertical: Nums.paddingNormal,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "WARNING !!!",
                  style: GoogleFonts.spectral(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                vs(5),
                Text(
                  message,
                  style: GoogleFonts.spectral(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Duration",
                        style: GoogleFonts.spectral(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      ": ",
                      style: GoogleFonts.spectral(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        DTFunctions().formatDuration(testDuration),
                        style: GoogleFonts.spectral(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Remaining",
                        style: GoogleFonts.spectral(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      ":",
                      style: GoogleFonts.spectral(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        DTFunctions().formatDuration(remainingSeconds),
                        style: GoogleFonts.spectral(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        height: 50,
                        onPressed: () {
                          Get.back();
                          TestDetailUIController().to.startTimer();
                        },
                        child: Text(
                          "RETAKE TEST",
                          style: GoogleFonts.spectral(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 0.5,
                      height: 30,
                      color: Colors.black,
                    ),
                    Expanded(
                      child: MaterialButton(
                        height: 50,
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        child: Text(
                          "EXIT",
                          style: GoogleFonts.spectral(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
