class Content {
  late String id;
  late String courseId;
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
  });

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    name = json['name'];
    slug = json['slug'];
    type = json['type'];
    mode = json['mode'];
    duration = json['duration'];
    price = json['price'];
    published = json['published'];
    videoLink = json['video_link'];
    filePath = json['file_path'];
    content = json['content'];
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
    };
  }
}
