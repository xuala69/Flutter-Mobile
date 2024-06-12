class User {
  late int id;
  late String name;
  late String email;
  String? address;
  String? phoneNumber;
  String? avatarPath;
  String? status;
  late List<ActiveContent> activeCourses;
  late List<ActiveContent> activeContents;
  late List<ActiveContent> activeMockTests;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.address,
    this.phoneNumber,
    this.avatarPath,
    this.status,
    required this.activeCourses,
    required this.activeContents,
    required this.activeMockTests,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    avatarPath = json['avatar_path'];
    status = json['status'];
    activeCourses = [];
    activeContents = [];
    activeMockTests = [];
    final courseJs = json['active_courses'];
    final contentJs = json['active_contents'];
    final testJs = json['active_mock_tests'];
    if (courseJs is List) {
      for (var element in courseJs) {
        activeCourses.add(ActiveContent.fromJson(element));
      }
    }
    if (contentJs is List) {
      for (var element in contentJs) {
        activeContents.add(ActiveContent.fromJson(element));
      }
    }
    if (testJs is List) {
      for (var element in testJs) {
        activeMockTests.add(ActiveContent.fromJson(element));
      }
    }
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
      "active_courses": activeCourses.map((e) => e.toJson()).toList(),
      "active_contents": activeContents.map((e) => e.toJson()).toList(),
      "active_mock_tests": activeMockTests.map((e) => e.toJson()).toList(),
    };
  }
}

class ActiveContent {
  late int payableId;
  late String expiresAt;

  ActiveContent({
    required this.payableId,
    required this.expiresAt,
  });

  ActiveContent.fromJson(Map<String, dynamic> json) {
    payableId = json['payable_id'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      "payable_id": payableId,
      "expires_at": expiresAt,
    };
  }
}
