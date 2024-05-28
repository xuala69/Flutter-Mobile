import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/user_controller.dart';
import 'package:prep_pro/ui/home/Profile/widgets/sub_divider.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/strings.dart';

class ProfileMainPage extends StatelessWidget {
  ProfileMainPage({super.key});

  final userCtrl = UserController().to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          RotatedBox(
            quarterTurns: 1,
            child: PopupMenuButton<int>(
              onSelected: (item) {
                log("Delete account ");
              },
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    'Delete Account',
                  ),
                ),
              ],
            ),
          ),
          hs(15),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          vs(15),
          avatarName(),
          const Divider(
            height: 1,
          ),
          iconTextCard(
            icon: Icons.list,
            title: "Payment History",
            subtitle: "Track payments,view details",
            onTap: () {},
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.menu_book,
            title: "Course History",
            subtitle: "View past Courses",
            onTap: () {},
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.checklist_outlined,
            title: "Exam History",
            subtitle: "View past Tests",
            onTap: () {},
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.list_alt,
            title: "Terms and Conditions",
            subtitle: "App usage Terms and Conditions",
            onTap: () {},
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            subtitle: "How your data is used",
            onTap: () {},
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.group,
            title: "About Us",
            subtitle: "FAQ, Contact 1% Club",
            onTap: () {},
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.logout_outlined,
            title: "Log out",
            subtitle: "Log out from current device",
            onTap: () {},
          ),
          const Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget iconTextCard(
      {required IconData icon,
      required String title,
      String? subtitle,
      required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: Nums.iconSizeProfile,
      ),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
    );
  }

  Widget avatarName() {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Row(
        children: [
          Container(
            width: Nums.avatarSize,
            height: Nums.avatarSize,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(Strings.avatarDefault),
              ),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(
                  () => Text(
                    userCtrl.user.value?.name ?? "Not available",
                    style: GoogleFonts.spectral(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    userCtrl.user.value?.email ?? "Email Not available",
                    style: GoogleFonts.spectral(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 15,
          )
        ],
      ),
    );
  }
}
