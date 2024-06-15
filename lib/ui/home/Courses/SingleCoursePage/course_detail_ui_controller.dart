import 'package:get/get.dart';
import 'package:prep_pro/controllers/contents_controller.dart';
import 'package:prep_pro/controllers/courses_controller.dart';
import 'package:prep_pro/models/content.dart';
import 'package:prep_pro/models/courses.dart';

class CourseDetailUIController extends GetxController {
  final courseCtrl = CoursesController().to;
  final contentCtrl = ContentsController().to;

  final loading = true.obs;
  final showExcerpt = true.obs;

  Rxn<Course> course = Rxn<Course>();

  final contents = RxList<Content>([]);

  void initiateController({required int newId, required String slug}) async {
    final results = await Future.wait([
      getCourse(slug),
      getCourseContents(newId),
    ]);
    final res1 = results[0] as Course?;
    final res2 = results[1] as List<Content>?;
    course.value = res1;
    if (res2 != null) {
      contents.value = res2;
    }
    contents.refresh();
    loading.value = false;
  }

  Future<Course?> getCourse(String slug) async {
    final data = await courseCtrl.getCourse(slug: slug);

    return data;
  }

  Future<List<Content>?> getCourseContents(int id) async {
    final data = await contentCtrl.getContents(courseId: id);
    return data;
  }

  @override
  void dispose() {
    // pagingController.dispose();
    super.dispose();
  }
}
