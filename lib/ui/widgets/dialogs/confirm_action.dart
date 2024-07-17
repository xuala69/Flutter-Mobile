import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

class ConfirmAction extends StatelessWidget {
  final String message;
  final VoidCallback onConfirmed;

  const ConfirmAction({
    required this.onConfirmed,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                  fontSize: 18,
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
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              vs(10),
              const Divider(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      height: 40,
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "CANCEL",
                        style: GoogleFonts.spectral(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 0.5,
                    height: 40,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: MaterialButton(
                      height: 40,
                      onPressed: () {
                        Get.back();
                        onConfirmed();
                      },
                      child: Text(
                        "CONFIRM",
                        style: GoogleFonts.spectral(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
