class Organization {
  late int id;
  late String name;
  late String slug;
  String? imagePath;
  String? description;
  late bool isSelected;

  Organization({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.imagePath,
    this.isSelected = false,
  });

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    imagePath = json['image_path'];
    isSelected = json['is_selected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "image_path": imagePath,
      "description": description,
      "is_selected": isSelected,
    };
  }
}
