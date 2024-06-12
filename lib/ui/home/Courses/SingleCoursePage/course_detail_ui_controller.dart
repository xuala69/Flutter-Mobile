import 'package:get/get.dart';
import 'package:prep_pro/controllers/contents_controller.dart';
import 'package:prep_pro/controllers/courses_controller.dart';
import 'package:prep_pro/models/content.dart';
import 'package:prep_pro/models/courses.dart';

class CourseDetailUIController extends GetxController {
  final courseCtrl = CoursesController().to;
  final contentCtrl = ContentsController().to;

  final loading = true.obs;

  Rxn<Course> course = Rxn<Course>();

  final contents = RxList<Content>([]);
  RxString courseSlug = "".obs;

  void initiateController(String newId) async {
    courseSlug.value = newId;
    final results = await Future.wait([
      getCourse(),
      getCourseContents(),
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

  Future<Course?> getCourse() async {
    final data = await courseCtrl.getCourse(slug: courseSlug.value);

    return data;
  }

  Future<List<Content>?> getCourseContents() async {
    final data = await contentCtrl.getContents(courseId: courseSlug.value);
    return data;
  }

  @override
  void dispose() {
    // pagingController.dispose();
    super.dispose();
  }
}
