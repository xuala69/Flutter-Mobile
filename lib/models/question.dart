// class Question {
//   late String id;
//   late String name;
//   late String explanation;
//   String? image;
//   late List<Option> options;
//   late String correctOption;
//   Option? answer;

//   Question({
//     required this.id,
//     required this.name,
//     required this.explanation,
//     this.image,
//     required this.options,
//     required this.correctOption,
//     this.answer,
//   });

//   Question.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     explanation = json['explanation'];
//     image = json['image'];
//     correctOption = json['correct_option'];
//     answer = json['answer'] == null ? null : Option.fromJson(json['answer']);
//     options = [];
//     final js = json['options'];
//     if (js is List) {
//       for (var element in js) {
//         final model = Option.fromJson(element);
//         options.add(model);
//       }
//     }
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "name": name,
//       "explanation": explanation,
//       "image": image,
//       "correct_option": correctOption,
//       "options": options.map((e) => e.toJson()).toList(),
//       "answer": answer?.toJson(),
//     };
//   }
// }

// class Option {
//   late String key;
//   late String value;

//   Option({
//     required this.key,
//     required this.value,
//   });

//   Option.fromJson(Map<String, dynamic> json) {
//     key = json['key'];
//     value = json['value'];
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "key": key,
//       "value": value,
//     };
//   }
// }
