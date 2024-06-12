class Question {
  late String id;
  late String name;
  late String explanation;
  String? image;
  late List<Option> options;
  late String correctOption;

  Question({
    required this.id,
    required this.name,
    required this.explanation,
    this.image,
    required this.options,
    required this.correctOption,
  });

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    explanation = json['explanation'];
    image = json['image'];
    correctOption = json['correct_option'];
    options = [];
    final js = json['options'];
    if (js is List) {
      for (var element in js) {
        final model = Option.fromJson(element);
        options.add(model);
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "explanation": explanation,
      "image": image,
      "correct_option": correctOption,
      "options": options.map((e) => e.toJson()).toList()
    };
  }
}

class Option {
  late String key;
  late String value;
  String? answer;

  Option({
    required this.key,
    required this.value,
    this.answer,
  });

  Option.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    return {
      "key": key,
      "value": value,
      "answer": answer,
    };
  }
}
