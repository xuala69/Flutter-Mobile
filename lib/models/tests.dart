import 'package:prep_pro/models/category.dart';
import 'package:prep_pro/models/organization.dart';

class Test {
  late int id;
  late int organizationId;
  late String name;
  late String slug;
  late String description;
  late String mode;
  late int questionsCount;
  late int duration;
  late double price;
  late bool published;
  late bool featured;
  String? imagePath;
  late int categoryId;
  Organization? organization;
  Category? category;

  Test({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.slug,
    required this.description,
    required this.mode,
    required this.questionsCount,
    required this.duration,
    required this.price,
    required this.published,
    required this.featured,
    this.imagePath,
    required this.categoryId,
    this.organization,
    this.category,
  });

  Test.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    organizationId = json['organization_id'];
    slug = json['slug'];
    description = json['description'];
    mode = json['mode'];
    questionsCount = json['questions_count'];
    duration = json['duration'];
    final priceT = json['price'];
    if (priceT is int) {
      price = double.parse(priceT.toString());
    } else {
      price = priceT;
    }
    published = true;
    // json['published'];
    featured = true;
    // json['featured'];
    imagePath = json['image_path'];
    categoryId = json['category_id'];
    //organization
    final orgJs = json['organization'];
    if (orgJs != null) {
      final model = Organization.fromJson(orgJs);
      organization = model;
    }
    final catJs = json['category'];
    if (catJs != null) {
      final model = Category.fromJson(orgJs);
      category = model;
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
      "questions_count": questionsCount,
      "duration": duration,
      "price": price,
      "published": published,
      "featured": featured,
      "image_path": imagePath,
      "category_id": categoryId,
      "organization": organization?.toJson(),
      "category": category?.toJson(),
    };
  }
}
