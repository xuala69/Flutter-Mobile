import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prep_pro/controllers/categories_controller.dart';
import 'package:prep_pro/controllers/tests_controller.dart';
import 'package:prep_pro/models/category.dart';
import 'package:prep_pro/models/tests.dart';
import 'package:prep_pro/utils/nums.dart';

class TestsUIController extends GetxController {
  static const _pageSize = 10;

  RxList<Category> categories = CategoriesController().to.categories;
  var isLoadingCategories = true.obs;
  final PagingController<int, Test> pagingController =
      PagingController(firstPageKey: 1);

  final searchText = "".obs;

  var sortOptions = <String, dynamic>{}.obs;

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    debounce(
      searchText,
      (value) {
        refresh();
      },
      time: const Duration(milliseconds: Nums.debounceMs),
    );
    super.onInit();
  }

  void submitSort(Map<String, dynamic> newOption) {
    searchText.value = "";
    sortOptions.value = newOption;
    refresh();
  }

  @override
  void refresh() {
    pagingController.itemList?.clear();
    // _pagingController.refresh();
    _fetchPage(1);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // Replace with your API call
      final newItems = await fetchItemsFromApi(pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<Test>> fetchItemsFromApi(int page) async {
    final ctrl = TestsController().to;
    // ignore: invalid_use_of_protected_member
    final sortMap = sortOptions.value;
    final data = await ctrl.getTests(pageNo: page, filter: {
      "search": searchText.value,
      "category_ids": sortMap['categories'],
      "subject_ids": sortMap['subjects'],
      "organization_ids": sortMap['organizations'],
      "sort": sortMap['sort'],
    });
    log("Returned value from api with search:${searchText.value} $data");
    return data ?? [];
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
