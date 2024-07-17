import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/ui/home/Profile/profile_main.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/strings.dart';

AppBar mAppbar() {
  return AppBar(
    title: Row(
      children: [
        const Icon(
          Icons.g_mobiledata,
          size: 45,
          color: Colors.white,
        ),
        Text(
          "1% Club",
          style: GoogleFonts.roboto(
            color: Colors.grey[200],
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    ),
    centerTitle: false,
    backgroundColor: AppColors.primary,
    actions: [
      FloatingActionButton(
        onPressed: () {
          Get.to(() => ProfileMainPage());
        },
        mini: true,
        shape: const CircleBorder(),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                Strings.avatarDefault,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      hs(25)
    ],
  );
}
