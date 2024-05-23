class Organization {
  late String id;
  late String name;
  late String slug;
  String? imagePath;
  String? description;

  Organization({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.imagePath,
  });

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "image_path": imagePath,
      "description": description,
    };
  }
}
