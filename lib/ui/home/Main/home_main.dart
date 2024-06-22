import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/models/home_item.dart';
import 'package:prep_pro/utils/nums.dart';
import 'home_main_ui_controller.dart';
import 'widgets/carousel.dart';
import 'widgets/horizontal_list.dart';
import 'widgets/recent_courses.dart';
import 'widgets/recent_tests.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final HomeUIController ctrl = HomeUIController().to;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ctrl.loading.isTrue) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      } else {
        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: Nums.paddingNormal,
            right: Nums.paddingNormal,
            top: Nums.paddingNormal,
            bottom: Nums.paddingXXXHigh,
          ),
          children: ctrl.homeItems.map((e) => getItem(e)).toList(),
        );
      }
    });
  }

  Widget getItem(HomeItem item) {
    switch (item.type.toLowerCase()) {
      case "banner":
        {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (item.caption != null)
                Text(
                  item.caption!,
                  style: GoogleFonts.spectral(
                    fontSize: 18,
                  ),
                ),
              HomeCarouselWidget(
                items: item.items,
              ),
            ],
          );
        }
      case "recent-courses":
        {
          return RecentCourses();
        }
      case "horizontal-list":
        {
          return HorizontalList(item: item);
        }
      case "recent-mock-tests":
        {
          return RecentTests();
        }

      default:
        {
          return const Center(
            child: Text("Data not matching existing UI"),
          );
        }
    }
  }
}
