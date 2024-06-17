import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prep_pro/controllers/categories_controller.dart';
import 'package:prep_pro/models/tests.dart';
import 'package:prep_pro/ui/home/Filter/filter_sheet.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';
import 'mock_tests_ui_controller.dart';
import 'widgets/test_grid.dart';
import 'widgets/searchbar.dart';

class HomeTestsPage extends StatefulWidget {
  const HomeTestsPage({super.key});

  @override
  State<HomeTestsPage> createState() => _HomeTestsPageState();
}

class _HomeTestsPageState extends State<HomeTestsPage> {
  final categoriesCtrl = CategoriesController().to;
  final uiCtrl = Get.put(TestsUIController());

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
            child: PagedGridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 220,
                mainAxisSpacing: Nums.paddingSmall,
                crossAxisSpacing: Nums.paddingSmall,
              ),
              builderDelegate: PagedChildBuilderDelegate<Test>(
                itemBuilder: (context, item, index) {
                  return TestGrid(
                    test: item,
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
              padding: EdgeInsets.only(
                left: Nums.paddingNormal,
                right: Nums.paddingNormal,
                bottom: 110,
              ),
              // separatorBuilder: (context, index) => vs(5),
            ),
          ),
        )
      ],
    );
  }
}
