import 'package:prep_pro/models/courses.dart';

class CourseHistory {
  late String id;
  late int currentStep;
  late DateTime savedAt;
  Course? course;

  CourseHistory({
    required this.id,
    required this.currentStep,
    required this.savedAt,
    required this.course,
  });

  CourseHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currentStep = json['current_step'];
    savedAt = DateTime.parse(json['saved_at']);
    final courseJs = json['course'];
    if (courseJs != null) {
      final model = Course.fromJson(courseJs);
      course = model;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "current_step": currentStep,
      "saved_at": savedAt.toIso8601String(),
      "course": course!.toJson(),
    };
  }
}
