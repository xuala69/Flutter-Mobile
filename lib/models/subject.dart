class Subject {
  late int id;
  late String name;
  late String slug;
  late String description;
  late int contentsCount;
  late bool published;
  late bool featured;
  String? imagePath;
  late bool isSelected;

  Subject({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.contentsCount,
    required this.published,
    required this.featured,
    this.imagePath,
    this.isSelected = false,
  });

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    contentsCount = json['contents_count'];
    published = json['published'];
    featured = json['featured'];
    imagePath = json['image_path'];
    isSelected = json['is_selected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "description": description,
      "contents_count": contentsCount,
      "published": published,
      "featured": featured,
      "image_path": imagePath,
      "is_selected": isSelected,
    };
  }
}
