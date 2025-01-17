import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/auth_controller.dart';
import 'package:prep_pro/controllers/user_controller.dart';
import 'package:prep_pro/ui/home/Profile/widgets/sub_divider.dart';
import 'package:prep_pro/ui/widgets/dialogs/confirm_action.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/strings.dart';

import '../Pages/page_details.dart';

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
                Get.dialog(ConfirmAction(
                  message:
                      "Are you sure you want to delete your account? All information like purchase history, courses taken, test results etc., will be deleted and can't be recovered?",
                  onConfirmed: () {
                    Get.back();
                    AuthController().to.signOut();
                    //TODO delete account
                  },
                ));
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
            title: "Test History",
            subtitle: "View past Tests",
            onTap: () {},
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.list_alt,
            title: "Terms and Conditions",
            subtitle: "App usage Terms and Conditions",
            onTap: () {
              Get.to(
                () => const PageDetails(
                  slug: "terms-and-conditions",
                ),
              );
            },
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            subtitle: "How your data is used",
            onTap: () {
              Get.to(
                () => const PageDetails(
                  slug: "privacy-policy",
                ),
              );
            },
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.group,
            title: "About Us",
            subtitle: "FAQ, Contact 1% Club",
            onTap: () {
              Get.to(
                () => const PageDetails(
                  slug: "about-us",
                ),
              );
            },
          ),
          const SubDivider(),
          iconTextCard(
            icon: Icons.logout_outlined,
            title: "Log out",
            subtitle: "Log out from current device",
            onTap: () {
              Get.dialog(ConfirmAction(
                message: "Are you sure you want to sign out from this device?",
                onConfirmed: () {
                  Get.back();
                  AuthController().to.signOut();
                },
              ));
            },
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
