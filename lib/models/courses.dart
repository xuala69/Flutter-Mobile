class Course {
  late String id;
  late String organizationId;
  late String name;
  late String slug;
  late String description;
  late String mode;
  late int contentsCount;
  late int duration;
  late double price;
  late bool published;
  late bool featured;
  late String imagePath;
  late String categoryId;

  Course({
    required String id,
    required String organizationId,
    required String name,
    required String slug,
    required String description,
    required String mode,
    required String contentsCount,
    required String duration,
    required String price,
    required String published,
    required String featured,
    required String imagePath,
    required String categoryId,
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationId = json['organization_id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    mode = json['mode'];
    contentsCount = json['contents_count'];
    duration = json['duration'];
    price = json['price'];
    published = json['published'];
    featured = json['featured'];
    imagePath = json['image_path'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "organization_id": organizationId,
      "name": name,
      "slug": slug,
      "description": description,
      "mode": mode,
      "contents_count": contentsCount,
      "duration": duration,
      "price": price,
      "published": published,
      "featured": featured,
      "image_path": imagePath,
      "category_id": categoryId,
    };
  }
}
