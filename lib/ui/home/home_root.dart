import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:prep_pro/ui/home/Courses/courses.dart';
import 'package:prep_pro/ui/home/Exams/exams.dart';
import 'package:prep_pro/ui/home/Main/main.dart';

class HomeRootPage extends StatefulWidget {
  const HomeRootPage({super.key});

  @override
  State<HomeRootPage> createState() => _HomeRootPageState();
}

class _HomeRootPageState extends State<HomeRootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(
          Icons.g_mobiledata,
          size: 45,
          color: Colors.white,
        ),
        centerTitle: false,
        backgroundColor: Colors.purple[900],
        actions: [
          IconButton(
            onPressed: () {},
            color: Colors.white,
            icon: Icon(
              MdiIcons.accountOutline,
            ),
          ),
        ],
      ),
      body: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: const HomeMain(),
            item: ItemConfig(
              icon: Icon(MdiIcons.homeVariantOutline),
              iconSize: 34,
              title: "Home",
            ),
          ),
          PersistentTabConfig(
            screen: const HomeCoursesPage(),
            item: ItemConfig(
              icon: Icon(MdiIcons.schoolOutline),
              iconSize: 35,
              title: "Courses",
            ),
          ),
          PersistentTabConfig(
            screen: const HomeExamsPage(),
            item: ItemConfig(
              icon: const Icon(Icons.note_alt_outlined),
              iconSize: 35,
              title: "Exams",
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
