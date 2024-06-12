import 'package:prep_pro/models/organization.dart';

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
  String? imagePath;
  late String categoryId;
  Organization? organization;
  late String createdAt;

  Course({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.slug,
    required this.description,
    required this.mode,
    required this.contentsCount,
    required this.duration,
    required this.price,
    required this.published,
    required this.featured,
    this.imagePath,
    required this.categoryId,
    this.organization,
    required this.createdAt,
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    organizationId = json['organization_id'];
    slug = json['slug'];
    description = json['description'];
    mode = json['mode'];
    contentsCount = json['contents_count'];
    duration = json['duration'];
    price = json['price'];
    published = json['published'];
    featured = json['featured'];
    imagePath = json['image_path'];
    createdAt = json['created_at'] ?? DateTime.now().toIso8601String();
    categoryId = json['category_id'];
    //organization
    final orgJs = json['organization'];
    if (orgJs != null) {
      final model = Organization.fromJson(orgJs);
      organization = model;
    }
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
      "created_at": createdAt,
      "organization": organization?.toJson(),
    };
  }
}
