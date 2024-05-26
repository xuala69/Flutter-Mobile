class Category {
  late String id;
  late String name;
  late String slug;
  String? imagePath;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    this.imagePath,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "image_path": imagePath,
    };
  }
}
