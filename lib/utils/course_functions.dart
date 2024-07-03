import 'package:prep_pro/controllers/user_controller.dart';
import 'package:prep_pro/models/course.dart';

bool isCoursePlayable(Course course) {
  final activeCourses = UserController().to.user.value?.activeCourses ?? [];

  //check if course is free
  if (course.mode.toLowerCase() == "free") {
    return true;
  }
  //check if course is available at activeCourses

  for (var activeCourse in activeCourses) {
    if (course.id == activeCourse.payableId) {
      return true;
    }
  }

  return false;
}
