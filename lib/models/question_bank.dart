class QuestionBank {
  QuestionBank({
    required this.id,
    required this.questionBankId,
    required this.maximumTimeMs,
    required this.totalTimeSpent,
    required this.score,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.responses,
  });
  late final int id;
  late final int questionBankId;
  late final int maximumTimeMs;
  late final int totalTimeSpent;
  late final String score;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  String? deletedAt;
  late List<QuestionResponses> responses;

  QuestionBank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionBankId = json['question_bank_id'];
    maximumTimeMs = json['maximum_time'];
    totalTimeSpent = json['total_time_spent'];
    score = json['score'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = null;
    responses = List.from(json['responses'])
        .map((e) => QuestionResponses.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['question_bank_id'] = questionBankId;
    data['maximum_time'] = maximumTimeMs;
    data['total_time_spent'] = totalTimeSpent;
    data['score'] = score;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['responses'] = responses.map((e) => e.toJson()).toList();
    return data;
  }
}

class QuestionResponses {
  QuestionResponses({
    required this.id,
    required this.mockTestId,
    required this.questionId,
    this.answerResponse,
    required this.correct,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.question,
  });
  late final int id;
  late final int mockTestId;
  late final int questionId;
  String? answerResponse;
  late final bool correct;
  late final String createdAt;
  late final String updatedAt;
  String? deletedAt;
  late final Question question;

  QuestionResponses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mockTestId = json['mock_test_id'];
    questionId = json['question_id'];
    answerResponse = json['response'];
    correct = json['correct'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    question = Question.fromJson(json['question']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['mock_test_id'] = mockTestId;
    data['question_id'] = questionId;
    data['response'] = answerResponse;
    data['correct'] = correct;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['question'] = question.toJson();
    return data;
  }
}

class Question {
  Question({
    required this.id,
    required this.name,
    required this.mark,
    required this.negativeMark,
    required this.options,
    this.imagePath,
  });
  late final int id;
  late final String name;
  late final int mark;
  late final int negativeMark;
  late final List<Option> options;
  String? imagePath;

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mark = json['mark'];
    negativeMark = json['negative_mark'];
    options =
        List.from(json['options']).map((e) => Option.fromJson(e)).toList();
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mark'] = mark;
    data['negative_mark'] = negativeMark;
    data['options'] = options.map((e) => e.toJson()).toList();
    data['image_path'] = imagePath;
    return data;
  }
}

class Option {
  Option({
    required this.key,
    required this.label,
  });
  late final String key;
  late final String label;

  Option.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['key'] = key;
    data['label'] = label;
    return data;
  }
}
