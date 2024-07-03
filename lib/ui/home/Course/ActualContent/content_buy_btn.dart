import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/payment_controller.dart';
import 'package:prep_pro/controllers/user_controller.dart';
import 'package:prep_pro/models/content.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/course_content_functions.dart';
import 'package:prep_pro/utils/numbers_function.dart';
import 'package:prep_pro/utils/nums.dart';

import 'actual_pdf.dart';
import 'actual_text.dart';
import 'actual_video.dart';

class ContentBuyButton extends StatelessWidget {
  final Content content;
  ContentBuyButton({required this.content, super.key});
  final userCtrl = UserController().to;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isContentPlayable(content)) {
        return MaterialButton(
          onPressed: () {
            final widget = contentTypeWidget();
            Get.dialog(
              widget,
            );
          },
          padding: EdgeInsets.symmetric(
            vertical: Nums.paddingSmall,
          ),
          color: AppColors.primary,
          child: Text(
            content.type.toLowerCase().contains("video")
                ? "Start Watching"
                : "Start Reading",
            style: GoogleFonts.spectral(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        return MaterialButton(
          onPressed: () {
            final pay = Get.put(PaymentController());
            pay.buyContent(content: content);
          },
          padding: EdgeInsets.symmetric(
            vertical: Nums.paddingSmall,
          ),
          color: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                Nums.searchbarRadius,
              ),
            ),
          ),
          child: Text(
            "Buy ${formatToIndianRupees(content.price)}",
            style: GoogleFonts.spectral(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    });
  }

  Widget contentTypeWidget() {
    //TODO data ho hi a in open dik em check ala ngai lei a theih tak2 hunah
    switch (content.type.toLowerCase()) {
      case "pdf":
        {
          return ActualPdf(
            link: content.filePath ?? "",
          );
        }
      case "video_link":
        {
          return ActualVideo(
            link: content.videoLink!,
          );
        }
      case "text":
        {
          return ActualText(
            data: content.content!,
          );
        }
      default:
        {
          return const Center(
            child: Text(
              "The course content type is invalid. Please report to administrator",
            ),
          );
        }
    }
  }
}
