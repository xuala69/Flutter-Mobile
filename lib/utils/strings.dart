class Strings {
  static final Runes rupees = Runes(' \u{20B9}');
  static final Runes dollar = Runes(' \u{0024}');
  static String baseUrl = "https://onepercent.com";
  static String coursesUrl = "api/courses";
  static String examsUrl = "api/exams";
  static String googleUrl = 'auth/google-auth-redirect';
  static String appleUrl = 'auth/apple-auth-redirect';
  static String avatarDefault =
      "https://firebasestorage.googleapis.com/v0/b/exam-prep-pro.appspot.com/o/adventurer-1716143676740.png?alt=media&token=263ae486-ce31-429f-bb4a-253a4058f95d";
}

class LocalKeys {
  static String user = "user";
  static String userToken = "user_token";
  static String subjects = "subjects";
  static String popularCourses = "popular_courses";
  static String featuredCourses = "featured_courses";
  static String courseHistory = "course_history";
  static String popularExams = "popular_exams";
  static String featuredExams = "featured_exams";
  static String examHistory = "exam_history";
  static String categories = "categories";
  static String organizations = "organizations";
  static String sortOptions = "sort_options";
}

String sampleCourseJs = """
{
    "id": 2,
    "organization_id": 2,
    "category_id": 2,
    "subject_id": 2,
    "name": "Shannon Salazar",
    "slug": "shannon-salazar",
    "description": "<p>Morbi sagittis dolor arcu, eu venenatis dui aliquet eu. Donec ac lorem volutpat, tristique elit ac, dapibus dolor. Suspendisse rutrum dictum augue sed placerat. Aliquam sit amet dolor a eros fringilla ullamcorper ac et diam. Quisque sodales leo at varius posuere. Duis non ante nunc. Mauris sed congue nulla. Curabitur posuere non dui vitae viverra. Aliquam erat volutpat. Mauris fermentum blandit orci id dapibus. Proin lacinia aliquam fringilla. Nam ac mauris convallis, feugiat dolor et, gravida orci.<br><br>Pellentesque volutpat rhoncus justo et eleifend. Nam tempus, metus ut semper posuere, urna nisl hendrerit mauris, at ultrices orci enim et est. Vestibulum et bibendum dolor. Nullam sed quam ligula. In ornare ultricies lorem, a iaculis ipsum finibus quis. Quisque tincidunt, ante eleifend egestas accumsan, ligula sapien pulvinar sem, lobortis fermentum nisi nisi blandit arcu. Proin et finibus libero.<br><br>Praesent quis justo lacinia, rhoncus nibh at, imperdiet metus. Suspendisse congue metus vel ligula condimentum, at rutrum lectus efficitur. Ut ut interdum sapien. Ut semper pellentesque mattis. Phasellus pulvinar tortor in volutpat mollis. Proin venenatis imperdiet molestie. Mauris vel risus consectetur, facilisis magna a, vestibulum mi. Fusce semper, libero sed venenatis vestibulum, ipsum ipsum euismod neque, a varius nibh felis non lorem. Integer a ipsum porta, convallis ipsum at, varius elit. In rhoncus ligula vitae est imperdiet dictum. Donec et metus euismod, commodo lorem in, bibendum leo. Vestibulum eu metus imperdiet, malesuada quam in, ullamcorper tortor.<br><br>Integer imperdiet consequat tempus. Phasellus eleifend metus blandit magna volutpat, id luctus erat vehicula. Aliquam erat volutpat. Maecenas quis nunc massa. Sed eu ante in velit aliquam mattis et at ex. Nunc cursus eget felis nec pharetra. Nunc ac lobortis ipsum, quis rhoncus massa. Aliquam erat volutpat. Aliquam ut porttitor neque. Praesent justo metus, volutpat ac lacinia sed, tempor vel ligula. Nulla suscipit tellus maximus, aliquam ipsum quis, imperdiet augue. Vestibulum placerat ex ac ornare ullamcorper. Donec eget enim quis sem sollicitudin viverra. Mauris ut ex iaculis, porta est id, auctor turpis. Morbi tempor nibh et ipsum viverra, ac sagittis neque tincidunt. Cras maximus, arcu nec euismod accumsan, nisi turpis ullamcorper odio, eget volutpat turpis sapien ut augue.<br><br>Praesent suscipit nulla in velit interdum placerat. Nulla feugiat ante eget turpis facilisis ultrices facilisis vitae augue. Aenean aliquet justo id sapien laoreet, at consectetur tortor posuere. Sed eleifend congue convallis. Aliquam porttitor ex ligula, at malesuada nunc tristique ut. Aliquam at neque vel est luctus eleifend. Suspendisse id orci quis leo porttitor tempus a id ligula. Aliquam erat volutpat.<br><br>Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam id finibus augue. Suspendisse potenti. Nam massa elit, eleifend id fringilla et, efficitur eget augue. Duis quis sodales dui. Sed tempus malesuada dolor, sed auctor ante ullamcorper ac. Integer dignissim massa sit amet tortor interdum, sit amet pellentesque nisl suscipit. Integer sollicitudin nisi in ultrices convallis.</p>",
    "mode": "free",
    "contents_count": "0",
    "duration": 6,
    "price": 337,
    "published": true,
    "featured": true,
    "image_path": "categories/01HYJSW8SA1ZNB8K77G80ZCH57.png",
    "created_at": "2024-05-23T13:22:35.000000Z",
    "updated_at": "2024-05-23T13:22:35.000000Z",
    "deleted_at": null,
    "organization": {
        "id": 2,
        "name": "Darbu Music",
        "slug": "darbu-music",
        "image_path": "organizations/01HYJSMX8DRN291PNY89AH4052.png",
        "description": null,
        "created_at": "2024-05-23T13:18:34.000000Z",
        "updated_at": "2024-05-23T13:18:34.000000Z",
        "deleted_at": null
    },
    "subject": {
        "id": 2,
        "name": "English",
        "slug": "english",
        "image_path": "subjects/01HYJSQ8CDZ5X8T94AEY73D49A.png",
        "created_at": "2024-05-23T13:19:51.000000Z",
        "updated_at": "2024-05-23T13:19:51.000000Z",
        "deleted_at": null
    },
    "category": {
        "id": 2,
        "name": "UPSC",
        "slug": "upsc",
        "image_path": "categories/01HYJSEEPQCNQAJWVF7M05MF7T.jpg",
        "created_at": "2024-05-23T13:15:02.000000Z",
        "updated_at": "2024-05-23T13:15:02.000000Z",
        "deleted_at": null
    }
}
""";
