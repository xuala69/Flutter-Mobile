import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prep_pro/controllers/tests_controller.dart';
import 'package:prep_pro/models/tests.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/strings.dart';

class SearchItemsPage extends StatefulWidget {
  const SearchItemsPage({
    super.key,
    this.hideFilter,
    required this.filters,
  });

  final List<String> filters;
  final bool? hideFilter;

  @override
  State<SearchItemsPage> createState() => _SearchItemsPageState();
}

class _SearchItemsPageState extends State<SearchItemsPage> {
  // late String _selectedFilter;
  final ctrl = Get.put(TestsController());

  final PagingController<int, Test> _pagingController =
      PagingController(firstPageKey: 1);
  final searchText = "".obs;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    // _selectedFilter = widget.filters.first;

    super.initState();
    debounce(
      searchText,
      (value) {
        refresh();
      },
      time: const Duration(milliseconds: Nums.debounceMs),
    );
  }

  void refresh() {
    _pagingController.itemList?.clear();
    // _pagingController.refresh();
    _fetchPage(1);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      log("Fetch page called with search text: ${searchText.value}");
      final newItems = await fetch(pageNo: pageKey);
      final isLastPage = newItems.length < 15;
      if (isLastPage) {
        setState(() {
          if (pageKey == 1) {
            _pagingController.itemList?.clear();
          }
          _pagingController.appendLastPage(newItems);
        });
      } else {
        setState(() {
          if (pageKey == 1) {
            _pagingController.itemList?.clear();
          }
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems, nextPageKey);
        });
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<List<Test>> fetch({required int pageNo}) async {
    log("fetch called with text ${searchText.value}");
    var res = await ctrl.getTests(
      filter: {
        "search": searchText.value,
      },
      pageNo: pageNo,
    );
    return res ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            _buildSearchBar(),
          ];
        },
        body: buildBody(),
      ),
    );
  }

  Widget _buildResultCard(Test model) {
    return InkWell(
      onTap: () {
        // Get.bottomSheet(
        //   modelDetailSheet(modelId: model.id),
        //   isScrollControlled: true,
        // );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: 40,
              height: 40,
              child: CachedNetworkImage(
                imageUrl: Strings.avatarDefault,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.center,
                      image: imageProvider,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(Nums.searchbarRadius),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error_outline),
                ),
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(Nums.searchbarRadius),
                    ),
                  ),
                ),
              ),
            ),
            hs(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  vs(5),
                  Text(
                    model.organization?.name ?? "",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _pagingController.refresh(),
      ),
      child: PagedListView.separated(
          builderDelegate: PagedChildBuilderDelegate<Test>(
            itemBuilder: (context, item, index) {
              return _buildResultCard(item);
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
                    //       opacity: const AlwaysStoppedAnimation<double>(0.6),
                    //     )),
                    vs(35),
                    Text(
                      "No items found",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 22,
                          ),
                    ),
                    vs(10),
                    Text(
                      "Please try again later",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
          pagingController: _pagingController,
          padding: EdgeInsets.only(
            left: Nums.paddingNormal,
            right: Nums.paddingNormal,
            bottom: 110,
          ),
          separatorBuilder: (context, index) => vs(5)),
    );
  }

  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              margin: const EdgeInsets.only(
                left: 15,
                right: 8,
                bottom: 0,
                top: 0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey[500]!.withOpacity(0.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 0,
                        bottom: 0,
                        top: 0,
                      ),
                      child: TextFormField(
                        autofocus: true,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            bottom: 8,
                          ),
                          suffixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                        onChanged: (newValue) {
                          searchText.value = newValue;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              searchText.value = "";
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(
                  Radius.circular(3),
                ),
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.3),
              ),
              child: Icon(
                Icons.clear,
                color: Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
