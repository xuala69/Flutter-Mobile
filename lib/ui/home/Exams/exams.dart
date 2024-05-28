import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prep_pro/controllers/categories_controller.dart';
import 'package:prep_pro/models/exams.dart';
import 'package:prep_pro/ui/home/Filter/filter_sheet.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/strings.dart';
import 'exams_ui_controller.dart';
import 'widgets/searchbar.dart';

class HomeExamsPage extends StatefulWidget {
  const HomeExamsPage({super.key});

  @override
  State<HomeExamsPage> createState() => _HomeExamsPageState();
}

class _HomeExamsPageState extends State<HomeExamsPage> {
  final categoriesCtrl = CategoriesController().to;
  final uiCtrl = Get.put(ExamsUIController());

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
              builderDelegate: PagedChildBuilderDelegate<Exam>(
                itemBuilder: (context, item, index) {
                  return GridTile(
                    footer: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              Nums.searchbarRadius,
                            ),
                            bottomRight: Radius.circular(
                              Nums.searchbarRadius,
                            ),
                          )),
                      child: Text(
                        item.name,
                        style: GoogleFonts.spectral(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    child: Container(
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
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            item.imagePath ?? Strings.avatarDefault,
                          ),
                        ),
                        color: Colors.grey[50],
                      ),
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
