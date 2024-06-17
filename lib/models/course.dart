import 'package:prep_pro/models/organization.dart';

class Course {
  late int id;
  late int subjectId;
  late int categoryId;
  late int organizationId;
  int? couponId;
  late String name;
  late String slug;
  late String description;
  late String mode;
  late int duration;
  late double price;
  String? imagePath;
  Organization? organization;
  late String createdAt;

  Course({
    required this.id,
    required this.subjectId,
    required this.categoryId,
    required this.organizationId,
    this.couponId,
    required this.name,
    required this.slug,
    required this.description,
    required this.mode,
    required this.duration,
    required this.price,
    this.imagePath,
    this.organization,
    required this.createdAt,
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectId = json['subject_id'];
    categoryId = json['category_id'];
    organizationId = json['organization_id'];
    couponId = json['coupon_id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    mode = json['mode'];
    duration = json['duration'];
    price = json['price'];
    imagePath = json['image_path'];
    createdAt = json['created_at'] ?? DateTime.now().toIso8601String();
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
      "subject_id": subjectId,
      "category_id": categoryId,
      "organization_id": organizationId,
      "coupon_id": couponId,
      "name": name,
      "slug": slug,
      "description": description,
      "mode": mode,
      "duration": duration,
      "price": price,
      "image_path": imagePath,
      "created_at": createdAt,
      "organization": organization?.toJson(),
    };
  }
}
