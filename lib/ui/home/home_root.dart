import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:prep_pro/ui/home/Courses/courses_tab.dart';
import 'package:prep_pro/ui/home/Exams/exams.dart';
import 'package:prep_pro/ui/home/Main/main.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/strings.dart';

class HomeRootPage extends StatefulWidget {
  const HomeRootPage({super.key});

  @override
  State<HomeRootPage> createState() => _HomeRootPageState();
}

class _HomeRootPageState extends State<HomeRootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      appBar: AppBar(
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
        backgroundColor: Colors.purple[900],
        actions: [
          FloatingActionButton(
            onPressed: () {},
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
      ),
      body: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: const HomeMain(),
            item: ItemConfig(
                icon: Icon(MdiIcons.homeVariant),
                iconSize: 34,
                title: "Home",
                // activeColorSecondary: Colors.purple,
                activeForegroundColor: Colors.purple[800]!,
                inactiveForegroundColor: Colors.grey[900]!,
                inactiveIcon: Icon(MdiIcons.homeVariantOutline)),
          ),
          PersistentTabConfig(
            screen: const HomeCoursesTab(),
            item: ItemConfig(
                icon: Icon(MdiIcons.school),
                iconSize: 35,
                title: "Courses",
                activeForegroundColor: Colors.purple[800]!,
                inactiveForegroundColor: Colors.grey[900]!,
                inactiveIcon: Icon(MdiIcons.schoolOutline)),
          ),
          PersistentTabConfig(
            screen: const HomeExamsPage(),
            item: ItemConfig(
              icon: const Icon(Icons.note_alt),
              iconSize: 35,
              title: "Exams",
              activeForegroundColor: Colors.purple[800]!,
              inactiveForegroundColor: Colors.grey[900]!,
              inactiveIcon: const Icon(Icons.note_alt_outlined),
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
        ),
      ),
    );
  }
}
