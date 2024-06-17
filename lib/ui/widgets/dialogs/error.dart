import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

class NetworkErrorDialog extends StatelessWidget {
  final String errorMsg;
  const NetworkErrorDialog({required this.errorMsg, super.key});

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
                "Something Went Wrong 😅",
                style: GoogleFonts.spectral(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              vs(5),
              Text(
                errorMsg,
                style: GoogleFonts.spectral(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      height: 50,
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("OKAY"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
