class InfoPage {
  late int id;
  late String name;
  late String slug;
  late String contents;

  InfoPage({
    required this.id,
    required this.name,
    required this.slug,
    required this.contents,
  });

  InfoPage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    contents = json['contents'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "contents": contents,
    };
  }
}
