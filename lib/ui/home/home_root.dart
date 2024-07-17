import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:prep_pro/ui/home/Course/courses_tab.dart';
import 'package:prep_pro/ui/home/Tests/mock_tests.dart';
import 'package:prep_pro/ui/home/Main/home_main.dart';
import 'package:prep_pro/utils/colors.dart';
import '../widgets/m_appbar.dart';

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
      appBar: mAppbar(),
      body: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: const HomeMain(),
            item: ItemConfig(
              icon: Icon(MdiIcons.homeVariant),
              iconSize: 30,
              title: "Home",
              // activeColorSecondary: Colors.purple,
              activeForegroundColor: AppColors.primary,
              inactiveForegroundColor: Colors.grey[900]!,
              inactiveIcon: Icon(MdiIcons.homeVariantOutline),
            ),
          ),
          PersistentTabConfig(
            screen: const HomeCoursesTab(),
            item: ItemConfig(
              icon: Icon(MdiIcons.school),
              iconSize: 30,
              title: "Courses",
              activeForegroundColor: AppColors.primary,
              inactiveForegroundColor: Colors.grey[900]!,
              inactiveIcon: Icon(MdiIcons.schoolOutline),
            ),
          ),
          PersistentTabConfig(
            screen: const HomeTestsPage(),
            item: ItemConfig(
              icon: const Icon(Icons.note_alt),
              iconSize: 30,
              title: "Mock Tests",
              activeForegroundColor: AppColors.primary,
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
