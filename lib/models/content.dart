class Content {
  late int id;
  late int courseId;
  late String name;
  late String slug;
  late String type;
  late String mode;
  late int duration;
  late double price;
  late bool published;
  String? videoLink;
  String? filePath;
  String? content;
  String? description;

  Content({
    required this.id,
    required this.courseId,
    required this.name,
    required this.slug,
    required this.type,
    required this.mode,
    required this.duration,
    required this.price,
    required this.published,
    this.videoLink,
    this.filePath,
    this.content,
    this.description,
  });

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    name = json['name'];
    slug = json['slug'];
    type = json['type'];
    mode = json['mode'];
    final tempDur = json['duration'];
    if (tempDur is int) {
      duration = tempDur;
    } else {
      duration = int.parse(tempDur);
    }
    final tempPrice = json['price'];
    if (tempPrice is double) {
      price = tempPrice;
    } else {
      price = double.parse(tempPrice.toString());
    }
    published = json['published'];
    videoLink = json['video_link'];
    filePath = json['file_path'];
    content = json['content'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "course_id": courseId,
      "name": name,
      "slug": slug,
      "type": type,
      "mode": mode,
      "duration": duration,
      "price": price,
      "published": published,
      "video_link": videoLink,
      "file_path": filePath,
      "content": content,
      "description": description,
    };
  }
}
