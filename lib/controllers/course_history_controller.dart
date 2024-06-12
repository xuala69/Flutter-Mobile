import 'package:get/get.dart';
import 'package:prep_pro/models/course_history.dart';
import '../utils/strings.dart';
import 'get_storage_controller.dart';

class CourseHistoryController extends GetxController {
  CourseHistoryController get to => Get.find();

  final courseHistories = RxList<CourseHistory>([]);

  @override
  void onReady() {
    _getCourseHistory();
    _listenCourseHistory();
    super.onReady();
  }

  _listenCourseHistory() {
    GetStorageController().to.box.listenKey(LocalKeys.courseHistory, (value) {
      if (value == null) {
        courseHistories.value = [];
      } else {
        courseHistories.clear();
        final List ls = value;
        for (var element in ls) {
          final model = CourseHistory.fromJson(element);
          courseHistories.add(model);
        }
      }
    });
  }

  _getCourseHistory() {
    final data = GetStorageController().to.box.read(LocalKeys.courseHistory);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = CourseHistory.fromJson(element);
        courseHistories.add(model);
      }
    } else {
      //TODO enthat leh ngai
      // GetStorageController().to.saveCourseHistory(
      //       CourseHistory(
      //         id: "1",
      //         currentStep: 2,
      //         savedAt: DateTime.now(),
      //         course: Course(
      //           id: "1",
      //           organizationId: "1",
      //           name: "Chiko | JEE",
      //           slug: 'JEE',
      //           description: "JEE Mains description",
      //           mode: "mode",
      //           createdAt: DateTime.now().toIso8601String(),
      //           contentsCount: 6,
      //           duration: 600,
      //           price: 1500.0,
      //           published: true,
      //           featured: true,
      //           imagePath: "https://picsum.photos/id/1/400/200",
      //           categoryId: "1",
      //           organization: Organization(
      //             id: "1",
      //             name: "Chiko Tuition Centre",
      //             slug: "slug",
      //           ),
      //         ),
      //       ),
      //     );
    }
  }
}
