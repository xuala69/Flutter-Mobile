import 'package:get/get.dart';
import 'package:prep_pro/controllers/courses_controller.dart';
import 'package:prep_pro/models/courses.dart';

class CourseDetailUIController extends GetxController {
  final ctrl = CoursesController().to;
  final loading = true.obs;

  Rxn<Course> course = Rxn<Course>();

  void getCourse(String courseId) async {
    final data = await ctrl.getCourse(courseId);
    course.value = data;
    loading.value = false;
  }

  // Future<List<Course>> fetchItemsFromApi(int page) async {
  //   // ignore: invalid_use_of_protected_member
  //   final sortMap = sortOptions.value;
  //   final data = await ctrl.getCourses(pageNo: page, filter: {
  //     "search": searchText.value,
  //     "category_ids": sortMap['categories'],
  //     "subject_ids": sortMap['subjects'],
  //     "organization_ids": sortMap['organizations'],
  //     "sort": sortMap['sort'],
  //   });
  //   log("Returned value from api with search:${searchText.value} $data");
  //   return data ?? [];
  // }

  @override
  void dispose() {
    // pagingController.dispose();
    super.dispose();
  }
}
