import 'package:prep_pro/controllers/user_controller.dart';
import 'package:prep_pro/models/content.dart';
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

bool isContentPlayable(Content content) {
  final activeCourses = UserController().to.user.value?.activeCourses ?? [];
  final activeContents = UserController().to.user.value?.activeContents ?? [];

  //check if content is free
  if (content.mode.toLowerCase() == "free") {
    return true;
  }
  //check if content is available at activecontents

  for (var activecontent in activeContents) {
    if (content.id == activecontent.payableId) {
      return true;
    }
  }

  //check if course containing content is purchased
  for (var activeCourse in activeCourses) {
    if (content.courseId == activeCourse.payableId) {
      return true;
    }
  }

  return false;
}
