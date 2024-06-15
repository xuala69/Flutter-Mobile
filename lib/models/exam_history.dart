import 'package:prep_pro/models/exams.dart';

class ExamHistory {
  late int id;
  late int currentStep;
  late DateTime savedAt;
  Exam? exam;

  ExamHistory({
    required this.id,
    required this.currentStep,
    required this.savedAt,
    required this.exam,
  });

  ExamHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currentStep = json['current_step'];
    savedAt = DateTime.parse(json['saved_at']);
    final examJs = json['exam'];
    if (examJs != null) {
      final model = Exam.fromJson(examJs);
      exam = model;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "current_step": currentStep,
      "saved_at": savedAt.toIso8601String(),
      "exam": exam!.toJson(),
    };
  }
}
