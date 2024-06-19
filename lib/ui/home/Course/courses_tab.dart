import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prep_pro/controllers/courses_controller.dart';
import 'package:prep_pro/models/course.dart';
import 'package:prep_pro/ui/home/Course/courses_ui_controller.dart';
import 'package:prep_pro/ui/home/Tests/widgets/searchbar.dart';
import 'package:prep_pro/ui/home/Filter/filter_sheet.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

import 'widgets/course_tile.dart';

class HomeCoursesTab extends StatefulWidget {
  const HomeCoursesTab({super.key});

  @override
  State<HomeCoursesTab> createState() => _HomeCoursesTabState();
}

class _HomeCoursesTabState extends State<HomeCoursesTab> {
  final coursesCtrl = CoursesController().to;
  final uiCtrl = Get.put(CoursesUIController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        vs(10),
        SearchBarWithFilter(
          onTextChanged: (newValue) {
            uiCtrl.searchText.value = newValue;
          },
          onFilterTap: () {
            Get.bottomSheet(
              FilterSheet(
                onSubmit: (data) {
                  if (data != null) {
                    uiCtrl.submitSort(data);
                  }
                },
              ),
              isScrollControlled: true,
            );
          },
        ),
        vs(Nums.paddingSmall),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => Future.sync(
              () => uiCtrl.pagingController.refresh(),
            ),
            child: PagedListView.separated(
              builderDelegate: PagedChildBuilderDelegate<Course>(
                itemBuilder: (context, item, index) {
                  return CourseListTile(
                    course: item,
                  );
                },
                firstPageErrorIndicatorBuilder: (context) => hs(0),
                noItemsFoundIndicatorBuilder: (context) => SizedBox(
                  height: Get.height * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // SizedBox(
                        //     height: Get.height * 0.20,
                        //     child: Image.asset(
                        //       "assets/empty_songs.png",
                        //       opacity:
                        //           const AlwaysStoppedAnimation<double>(0.6),
                        //     )),
                        vs(35),
                        Text(
                          "No items found",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 22,
                                  ),
                        ),
                        vs(10),
                        Text(
                          "Please try again later",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              pagingController: uiCtrl.pagingController,
              // padding: EdgeInsets.only(
              //   left = Nums.paddingNormal,
              //   right = Nums.paddingNormal,
              //   bottom = 110,
              // ),
              separatorBuilder: (context, index) => vs(15),
            ),
          ),
        )
      ],
    );
  }
}
