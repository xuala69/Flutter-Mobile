import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/models/test.dart';
import 'package:prep_pro/ui/home/MockTests/SingleTest/test_detail_page.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/numbers_function.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';

class TestGrid extends StatelessWidget {
  final MockTest test;
  const TestGrid({required this.test, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Get.to(
          () => TestDetailPage(
            testId: test.id,
            testSlug: test.slug,
          ),
        );
      },
      child: GridTile(
        footer: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Spacer(),
                getPricing(),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      Nums.searchbarRadius,
                    ),
                    bottomRight: Radius.circular(
                      Nums.searchbarRadius,
                    ),
                  )),
              child: Text(
                test.name,
                style: GoogleFonts.spectral(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300]!,
              ),
              top: BorderSide(
                color: Colors.grey[300]!,
              ),
              left: BorderSide(
                color: Colors.grey[300]!,
              ),
              right: BorderSide(
                color: Colors.grey[300]!,
              ),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                Nums.searchbarRadius,
              ),
            ),
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                getImageUrl(test.imagePath),
              ),
              fit: BoxFit.cover,
            ),
            color: Colors.grey[50],
          ),
        ),
      ),
    );
  }

  Widget getPricing() {
    if (test.mode.toLowerCase() == "free") {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.6),
          borderRadius: const BorderRadius.all(Radius.circular(1)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        child: Text(
          "Free",
          style: GoogleFonts.spectral(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.95),
          borderRadius: const BorderRadius.all(Radius.circular(1)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        child: Text(
          formatToIndianRupees(test.price),
          style: GoogleFonts.spectral(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      );
    }
  }
}
