import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prep_pro/controllers/courses_controller.dart';
import 'package:prep_pro/models/courses.dart';
import 'package:prep_pro/ui/home/Courses/courses_ui_controller.dart';
import 'package:prep_pro/ui/home/Exams/widgets/searchbar.dart';
import 'package:prep_pro/ui/home/Filter/filter_sheet.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/strings.dart';

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
                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: Nums.paddingNormal),
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
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: Nums.avatarSize,
                          height: Nums.avatarSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                Nums.searchbarRadius,
                              ),
                              bottomLeft: Radius.circular(
                                Nums.searchbarRadius,
                              ),
                            ),
                            color: Colors.grey[200],
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                item.imagePath ?? Strings.avatarDefault,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        hs(Nums.paddingNormal),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                item.name,
                                style: GoogleFonts.spectral(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                item.organization?.name ?? "",
                                style: GoogleFonts.spectral(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        hs(Nums.paddingNormal),
                      ],
                    ),
                  );
                },
                firstPageErrorIndicatorBuilder: (context) => hs(0),
                noItemsFoundIndicatorBuilder: (context) => SizedBox(
                  height: Get.height * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            height: Get.height * 0.20,
                            child: Image.asset(
                              "assets/empty_songs.png",
                              opacity:
                                  const AlwaysStoppedAnimation<double>(0.6),
                            )),
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
