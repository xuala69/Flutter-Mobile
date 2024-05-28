import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prep_pro/controllers/categories_controller.dart';
import 'package:prep_pro/controllers/exams_controller.dart';
import 'package:prep_pro/models/category.dart';
import 'package:prep_pro/models/exams.dart';

class ExamsUIController extends GetxController {
  static const _pageSize = 10;

  RxList<Category> categories = CategoriesController().to.categories;
  var isLoadingCategories = true.obs;
  final PagingController<int, Exam> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.onInit();
  }

  Future<void> fetchPage(int pageKey) async {
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

  Future<List<Exam>> fetchItemsFromApi(int page) async {
    final ctrl = ExamsController().to;
    final data = await ctrl.getExams(pageNo: page, filter: {});
    return data ?? [];
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
