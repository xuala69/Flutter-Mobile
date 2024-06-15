class Category {
  late int id;
  late String name;
  late String slug;
  late bool isSelected;
  String? imagePath;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    this.imagePath,
    this.isSelected = false,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    imagePath = json['image_path'];
    isSelected = json['is_selected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "image_path": imagePath,
      "is_selected": isSelected,
    };
  }
}
