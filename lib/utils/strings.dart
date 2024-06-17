class Strings {
  static final Runes rupees = Runes(' \u{20B9}');
  static final Runes dollar = Runes(' \u{0024}');
  static String avatarDefault =
      "https://firebasestorage.googleapis.com/v0/b/exam-prep-pro.appspot.com/o/adventurer-1716143676740.png?alt=media&token=263ae486-ce31-429f-bb4a-253a4058f95d";
  static String pdfLink =
      "https://www.clickdimensions.com/links/TestPDFfile.pdf";
  static String videoLink = "https://youtu.be/7g1WEB6aY34?si=MtdOKtepVuXQ4Rd6";
}

class Endpoints {
  // static String baseUrl = "https://onepercent.com";
  static String baseUrl = "http://13.232.142.18/";
  static String login = "v1/auth/login";
  static String storage = "storage/";
  static String user = "v1/auth/user";
  static String categories = "v1/categories"; // random/paginate
  static String category = "v1/category/"; // slug
  static String subjects = "v1/subjects"; // random/paginate
  static String subject = "v1/subject/"; // slug
  static String organizations = "v1/organizations"; // random/paginate
  static String organization = "v1/organization/"; // slug
  static String page = "v1/page/"; // slug
  static String courses = "v1/courses"; // random/paginate
  static String course = "v1/course/"; // slug
  static String content = "v1/content/"; // slug
  static String mockTests = "v1/mock-tests"; // popular/paginate
  static String mockTest = "v1/mock-test/"; // slug

  static String googleUrl = 'v1/auth/google-auth-redirect';
  static String appleUrl = 'v1/auth/apple-auth-redirect';
  static String emailpw = 'v1/auth/login';
  //TODO update discord url
  static String discord = 'https://discord/channel/id/webhook';
  static String payment = '/payment';
  static String paymentVerify = "/payment/verify";
}

class LocalKeys {
  static String user = "user";
  static String userToken = "user_token";
  static String subjects = "subjects";
  static String popularCourses = "popular_courses";
  static String featuredCourses = "featured_courses";
  static String courseHistory = "course_history";
  static String popularTests = "popular_tests";
  static String featuredTests = "featured_tests";
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
String sampleTextContent = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learn Flutter</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
        }
        h1, h2, h3 {
            color: #2c3e50;
        }
        p {
            color: #34495e;
        }
        code {
            background-color: transparent;
            padding: 2px 4px;
            border-radius: 4px;
        }
        pre {
            background-color: #f5f5f5;
            padding: 10px;
            border-radius: 5px;
            overflow-x: auto;
        }
    </style>
</head>
<body>

<h1>Introduction to Flutter</h1>

<p>Flutter is an open-source UI software development toolkit created by Google. It is used to develop cross-platform applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia, and the web from a single codebase.</p>

<h2>Getting Started</h2>

<p>To get started with Flutter, you need to have Flutter SDK and a suitable IDE (such as Android Studio or Visual Studio Code) installed on your machine.</p>

<pre>
<code>
// Install Flutter

// Add Flutter to your PATH

// Verify the installation
</code>
</pre>

<h2>Your First Flutter App</h2>

<p>Let's create a simple "Hello, World!" app in Flutter.</p>

<h2>Understanding the Code</h2>

<p>In the above code:</p>
<ul>
    <li><code>main()</code> function calls <code>runApp()</code>, which takes a <code>Widget</code> and makes it the root of the widget tree.</li>
    <li><code>MyApp</code> is a stateless widget. A stateless widget is a widget that does not require mutable state.</li>
    <li>The <code>build()</code> method describes how to display the widget in the UI. It returns a <code>MaterialApp</code> widget which is the root of the application.</li>
</ul>

<h2>Hot Reload</h2>

<p>One of the most powerful features of Flutter is <strong>hot reload</strong>. It allows you to quickly see the results of your code changes without restarting your app. This significantly speeds up the development process.</p>

<p>To use hot reload, simply:</p>
<ul>
    <li>Make changes to your Dart code.</li>
    <li>Save the changes.</li>
    <li>Observe the changes in the emulator or device.</li>
</ul>

<h2>Next Steps</h2>

<p>To learn more about Flutter, visit the <a href="https://flutter.dev/docs" target="_blank">official Flutter documentation</a>.</p>

</body>
</html>
""";
