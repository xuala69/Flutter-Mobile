class HomeItem {
  HomeItem({
    required this.id,
    required this.name,
    required this.type,
    this.caption,
    required this.order,
    required this.items,
  });
  late final int id;
  late final String name;
  late final String type;
  String? caption;
  late final int order;
  late final List<Items> items;

  HomeItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    caption = json['caption'];
    order = json['order'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['caption'] = caption;
    data['order'] = order;
    data['items'] = items.map((e) => e.toJson()).toList();
    return data;
  }
}

class Items {
  Items({
    required this.id,
    required this.mobileHomeId,
    this.name,
    this.caption,
    this.imagePath,
    required this.order,
    this.homeableType,
    this.homeableId,
    this.externalLink,
  });
  late final int id;
  late final int mobileHomeId;
  String? name;
  String? caption;
  String? imagePath;
  late final int order;
  String? homeableType;
  int? homeableId;
  String? externalLink;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobileHomeId = json['mobile_home_id'];
    name = json['name'];
    caption = json['caption'];
    imagePath = json['image_path'];
    order = json['order'];
    homeableType = json["homeable_type"];
    homeableId = json['homeable_id'];
    externalLink = json['external_link'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['mobile_home_id'] = mobileHomeId;
    data['name'] = name;
    data['caption'] = caption;
    data['image_path'] = imagePath;
    data['order'] = order;
    data['homeable_type'] = homeableType;
    data['homeable_id'] = homeableId;
    data['external_link'] = externalLink;
    return data;
  }
}

class Homeable {
  Homeable({
    required this.id,
    required this.name,
    required this.slug,
    required this.share,
    this.imagePath,
    this.description,
  });
  late final int id;
  late final String name;
  late final String slug;
  late final int share;
  String? imagePath;
  String? description;

  Homeable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    share = json['share'];
    imagePath = json['image_path'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['share'] = share;
    data['image_path'] = imagePath;
    data['description'] = description;
    return data;
  }
}
