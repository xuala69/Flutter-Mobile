class User {
  late String id;
  late String name;
  late String email;
  String? address;
  String? phoneNumber;
  String? avatarPath;
  String? status;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.address,
    this.phoneNumber,
    this.avatarPath,
    this.status,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    avatarPath = json['avatar_path'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "address": address,
      "phone_number": phoneNumber,
      "avatar_path": avatarPath,
      "status": status,
    };
  }
}
