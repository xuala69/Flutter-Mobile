import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/ui/home/Profile/profile_main.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/strings.dart';

AppBar mAppbar() {
  return AppBar(
    title: Container(
      height: 40,
      width: 40,
      // margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/logo.jpeg"),
        ),
        shape: BoxShape.circle,
      ),
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
