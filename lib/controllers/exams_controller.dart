import 'dart:developer';

import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/models/category.dart';
import 'package:prep_pro/models/exams.dart';
import 'package:prep_pro/models/organization.dart';
import 'package:prep_pro/models/questions.dart';
import 'package:prep_pro/utils/strings.dart';
import '../ui/widgets/function_widgets.dart';
import 'get_storage_controller.dart';

class ExamsController extends GetxController {
  ExamsController get to => Get.find();
  final dio = DioController().to.dio;

  final popularExams = RxList<Exam>([]);
  final featuredExams = RxList<Exam>([]);

  @override
  void onReady() {
    _getPopularExams();
    _listenPopularExams();
    //server atangin app open ah fetch that a save zel, local ami zel hman tur
    getPopularExams();
    //Exams
    _getFeaturedExams();
    _listenFeaturedExams();
    //server atangin app open ah fetch that a save zel, local ami zel hman tur
    getFeaturedExams();
    super.onReady();
  }

  _listenPopularExams() {
    GetStorageController().to.box.listenKey(LocalKeys.subjects, (value) {
      if (value == null) {
        popularExams.value = [];
      } else {
        popularExams.clear();
        final List ls = value;
        for (var element in ls) {
          final model = Exam.fromJson(element);
          popularExams.add(model);
        }
      }
    });
  }

  _getPopularExams() {
    final data = GetStorageController().to.box.read(LocalKeys.popularExams);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = Exam.fromJson(element);
        popularExams.add(model);
      }
    }
  }

  _listenFeaturedExams() {
    GetStorageController().to.box.listenKey(LocalKeys.featuredExams, (value) {
      if (value == null) {
        featuredExams.value = [];
      } else {
        featuredExams.clear();
        final List ls = value;
        for (var element in ls) {
          final model = Exam.fromJson(element);
          featuredExams.add(model);
        }
      }
    });
  }

  _getFeaturedExams() {
    final data = GetStorageController().to.box.read(LocalKeys.popularExams);
    if (data != null) {
      final List ls = data;
      for (var element in ls) {
        final model = Exam.fromJson(element);
        featuredExams.add(model);
      }
    }
  }

  Future<Exam?> getExam(int examId) async {
    try {
      log("Coming to get Exam with id $examId");
      final data = Exam(
        id: 3,
        organizationId: 1,
        name: "Class 12 Chemistry Mock Test",
        slug: 'Class 12 Chemistry',
        description: "Class 12 Chemistry description",
        mode: "free",
        contentsCount: 6,
        duration: 600,
        price: 1700.0,
        published: true,
        featured: true,
        imagePath: null,
        categoryId: 1,
        organization: Organization(
          id: 1,
          name: "Chiko Tuition Centre",
          slug: "slug",
        ),
        category: Category(
          id: 1,
          name: "JEE Mains",
          slug: "jee-mains",
        ),
      );
      return data;
      // final params = filter.putIfAbsent("page", () => pageNo);
      // filter.putIfAbsent("type", () => "paginate");
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Strings.ExamsUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Exam> Exams = [
      //     Exam(
      //       id: 1,
      //       organizationId: 1,
      //       name: "Chiko | JEE",
      //       slug: 'JEE',
      //       description: "JEE Mains description",
      //       mode: "free",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1500.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Exam(
      //       id: "2",
      //       organizationId: 1,
      //       name: "Chiko | NEET",
      //       slug: 'NEET',
      //       description: "NEET description",
      //       mode: "free",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1600.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Exam(
      //       id: "3",
      //       organizationId: 1,
      //       name: "Chiko | Class 12 Chemistry",
      //       slug: 'Class 12 Chemistry',
      //       description: "Class 12 Chemistry description",
      //       mode: "free",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1700.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //   ];
      //   final data = res.data['data'];
      //   if (data is List) {
      //     for (var element in data) {
      //       final model = Exam.fromJson(element);
      //       Exams.add(model);
      //     }
      //   }
      //   return Exams;
      // } else {
      //   final msg = res.data['message'] ?? "Unknown error occured";
      //   showErrorDialog(msg);
      //   return null;
      // }
    } catch (e) {
      log("GET Error exam ctrl:$e");
      final msg = e.toString();
      showErrorDialog(msg, "dummz");
      return null;
    }
  }

  Future<List<Question>?> getExamQuestions(int examId) async {
    try {
      log("Coming to get Exam Question with id $examId");
      final data = [
        Question(
          id: '1',
          name: "What is Science?",
          explanation: "Science is the bakramentis of the whow",
          options: [
            Option(
              key: "A",
              value: "A. Science",
            ),
            Option(
              key: "B",
              value: "B. Mathematics",
            ),
            Option(
              key: "C",
              value: "C. English",
            ),
            Option(
              key: "D",
              value: "D. Biology",
            ),
          ],
          correctOption: "A",
        ),
        Question(
          id: '2',
          name: "Where is Science?",
          explanation: "Science is the bakramentis of the whow",
          options: [
            Option(
              key: "A",
              value: "A. Science",
            ),
            Option(
              key: "B",
              value: "B. Mathematics",
            ),
            Option(
              key: "C",
              value: "C. English",
            ),
            Option(
              key: "D",
              value: "D. Biology",
            ),
          ],
          correctOption: "A",
        ),
        Question(
          id: '3',
          name: "When is Science?",
          explanation: "Science is the bakramentis of the whow",
          options: [
            Option(
              key: "A",
              value: "A. Science",
            ),
            Option(
              key: "B",
              value: "B. Mathematics",
            ),
            Option(
              key: "C",
              value: "C. English",
            ),
            Option(
              key: "D",
              value: "D. Biology",
            ),
          ],
          correctOption: "A",
        ),
        Question(
          id: '4',
          name: "How is Science?",
          explanation: "Science is the bakramentis of the whow",
          options: [
            Option(
              key: "A",
              value: "A. Science",
            ),
            Option(
              key: "B",
              value: "B. Mathematics",
            ),
            Option(
              key: "C",
              value: "C. English",
            ),
            Option(
              key: "D",
              value: "D. Biology",
            ),
          ],
          correctOption: "A",
        ),
        Question(
          id: '5',
          name: "What do the people of Chipko Movement do?",
          explanation: "Science is the bakramentis of the whow",
          options: [
            Option(
              key: "A",
              value: "A. Science",
            ),
            Option(
              key: "B",
              value: "B. Mathematics",
            ),
            Option(
              key: "C",
              value: "C. Both A&B",
            ),
            Option(
              key: "D",
              value: "D. All",
            ),
          ],
          correctOption: "A",
        ),
        Question(
          id: '6',
          name: "When does poligamate?",
          explanation: "Science is the bakramentis of the whow",
          options: [
            Option(
              key: "A",
              value: "A. Science",
            ),
            Option(
              key: "B",
              value: "B. Mathematics",
            ),
            Option(
              key: "C",
              value: "C. Both A&B",
            ),
            Option(
              key: "D",
              value: "D. All",
            ),
          ],
          correctOption: "A",
        ),
        Question(
          id: '7',
          name: "In case of Fire, what should you do?",
          explanation: "Science is the bakramentis of the whow",
          options: [
            Option(
              key: "A",
              value: "A. Science",
            ),
            Option(
              key: "B",
              value: "B. Mathematics",
            ),
            Option(
              key: "C",
              value: "C. Both A&B",
            ),
            Option(
              key: "D",
              value: "D. All",
            ),
          ],
          correctOption: "A",
        ),
        Question(
          id: '8',
          name: "What is the name of the Operting System used in macbooks?",
          explanation: "Science is the bakramentis of the whow",
          options: [
            Option(
              key: "A",
              value: "A. Macintosh",
            ),
            Option(
              key: "B",
              value: "B. Windows",
            ),
            Option(
              key: "C",
              value: "C. Linux",
            ),
            Option(
              key: "D",
              value: "D. WebOS",
            ),
          ],
          correctOption: "A",
        ),
        Question(
          id: '9',
          name: "Why was Six afraid of Seven?",
          explanation: "Science is the bakramentis of the whow",
          options: [
            Option(
              key: "A",
              value: "A. 789",
            ),
            Option(
              key: "B",
              value: "B. 123",
            ),
            Option(
              key: "C",
              value: "C. 456",
            ),
            Option(
              key: "D",
              value: "D. 345",
            ),
          ],
          correctOption: "A",
        ),
        Question(
          id: '10',
          name: "What is the fullform of AI?",
          explanation: "Science is the bakramentis of the whow",
          options: [
            Option(
              key: "A",
              value: "A. Apple Intelligence",
            ),
            Option(
              key: "B",
              value: "B. Artificial Intelligence",
            ),
            Option(
              key: "C",
              value: "C. Arebabu Instagnia",
            ),
            Option(
              key: "D",
              value: "D. Aunty Ingrid",
            ),
          ],
          correctOption: "B",
        ),
      ];
      // Exam(
      //   id: "3",
      //   organizationId: 1,
      //   name: "Class 12 Chemistry Mock Test",
      //   slug: 'Class 12 Chemistry',
      //   description: "Class 12 Chemistry description",
      //   mode: "free",
      //   contentsCount: 6,
      //   duration: 600,
      //   price: 1700.0,
      //   published: true,
      //   featured: true,
      //   imagePath: null,
      //   categoryId: 1,
      //   organization: Organization(
      //     id: 1,
      //     name: "Chiko Tuition Centre",
      //     slug: "slug",
      //   ),
      //   category: Category(
      //     id: 1,
      //     name: "JEE Mains",
      //     slug: "jee-mains",
      //   ),
      // );
      return data;
      // final params = filter.putIfAbsent("page", () => pageNo);
      // filter.putIfAbsent("type", () => "paginate");
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Strings.ExamsUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Exam> Exams = [
      //     Exam(
      //       id: 1,
      //       organizationId: 1,
      //       name: "Chiko | JEE",
      //       slug: 'JEE',
      //       description: "JEE Mains description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1500.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Exam(
      //       id: "2",
      //       organizationId: 1,
      //       name: "Chiko | NEET",
      //       slug: 'NEET',
      //       description: "NEET description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1600.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Exam(
      //       id: "3",
      //       organizationId: 1,
      //       name: "Chiko | Class 12 Chemistry",
      //       slug: 'Class 12 Chemistry',
      //       description: "Class 12 Chemistry description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1700.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //   ];
      //   final data = res.data['data'];
      //   if (data is List) {
      //     for (var element in data) {
      //       final model = Exam.fromJson(element);
      //       Exams.add(model);
      //     }
      //   }
      //   return Exams;
      // } else {
      //   final msg = res.data['message'] ?? "Unknown error occured";
      //   showErrorDialog(msg);
      //   return null;
      // }
    } catch (e) {
      log("GET Error exam ctrl:$e");
      final msg = e.toString();
      showErrorDialog(msg, "DUmmy exams ctrl");
      return null;
    }
  }

  Future<List<Exam>?> getExams({
    required int pageNo,
    required Map<String, dynamic> filter,
  }) async {
    try {
      log("Coming to get Exams");
      return [
        Exam(
          id: 1,
          organizationId: 1,
          name: "JEE Mock Test 1",
          slug: 'JEE',
          description: "JEE Mains description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1500.0,
          published: true,
          featured: true,
          imagePath: null,
          categoryId: 1,
          organization: Organization(
            id: 1,
            name: "Chiko Tuition Centre",
            slug: "slug",
          ),
          category: Category(
            id: 1,
            name: "JEE Mains",
            slug: "jee-mains",
          ),
        ),
        Exam(
          id: 2,
          organizationId: 1,
          name: "NEET Mock Test 2",
          slug: 'NEET',
          description: "NEET description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1600.0,
          published: true,
          featured: true,
          imagePath: null,
          categoryId: 1,
          organization: Organization(
            id: 1,
            name: "Chiko Tuition Centre",
            slug: "slug",
          ),
          category: Category(
            id: 1,
            name: "JEE Mains",
            slug: "jee-mains",
          ),
        ),
        Exam(
          id: 3,
          organizationId: 1,
          name: "Class 12 Chemistry Mock Test",
          slug: 'Class 12 Chemistry',
          description: "Class 12 Chemistry description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1700.0,
          published: true,
          featured: true,
          imagePath: null,
          categoryId: 1,
          organization: Organization(
            id: 1,
            name: "Chiko Tuition Centre",
            slug: "slug",
          ),
          category: Category(
            id: 1,
            name: "JEE Mains",
            slug: "jee-mains",
          ),
        ),
      ];
      // final params = filter.putIfAbsent("page", () => pageNo);
      // filter.putIfAbsent("type", () => "paginate");
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Strings.ExamsUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Exam> Exams = [
      //     Exam(
      //       id: 1,
      //       organizationId: 1,
      //       name: "Chiko | JEE",
      //       slug: 'JEE',
      //       description: "JEE Mains description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1500.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Exam(
      //       id: "2",
      //       organizationId: 1,
      //       name: "Chiko | NEET",
      //       slug: 'NEET',
      //       description: "NEET description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1600.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Exam(
      //       id: "3",
      //       organizationId: 1,
      //       name: "Chiko | Class 12 Chemistry",
      //       slug: 'Class 12 Chemistry',
      //       description: "Class 12 Chemistry description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1700.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //   ];
      //   final data = res.data['data'];
      //   if (data is List) {
      //     for (var element in data) {
      //       final model = Exam.fromJson(element);
      //       Exams.add(model);
      //     }
      //   }
      //   return Exams;
      // } else {
      //   final msg = res.data['message'] ?? "Unknown error occured";
      //   showErrorDialog(msg);
      //   return null;
      // }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg, "DUmmy exams ctrl 2");
      return null;
    }
  }

  void getPopularExams() async {
    try {
      final data = [
        Exam(
          id: 1,
          organizationId: 1,
          name: "JEE Mock Test 1",
          slug: 'JEE',
          description: "JEE Mains description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1500.0,
          published: true,
          featured: true,
          imagePath: null,
          categoryId: 1,
          organization: Organization(
            id: 1,
            name: "Chiko Tuition Centre",
            slug: "slug",
          ),
        ),
        Exam(
          id: 2,
          organizationId: 1,
          name: "NEET Mock Test 2",
          slug: 'NEET',
          description: "NEET description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1600.0,
          published: true,
          featured: true,
          imagePath: null,
          categoryId: 1,
          organization:
              Organization(id: 1, name: "Chiko Tuition Centre", slug: "slug"),
        ),
        Exam(
          id: 3,
          organizationId: 1,
          name: "Class 12 Chemistry Mock Test",
          slug: 'Class 12 Chemistry',
          description: "Class 12 Chemistry description",
          mode: "mode",
          contentsCount: 6,
          duration: 600,
          price: 1700.0,
          published: true,
          featured: true,
          imagePath: null,
          categoryId: 1,
          organization:
              Organization(id: 1, name: "Chiko Tuition Centre", slug: "slug"),
        ),
      ];
      GetStorageController().to.savePopularExams(data);

      // final params = filter.putIfAbsent("page", () => pageNo);
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Strings.ExamsUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Exam> Exams = [
      //     Exam(
      //       id: 1,
      //       organizationId: 1,
      //       name: "Chiko | JEE",
      //       slug: 'JEE',
      //       description: "JEE Mains description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1500.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Exam(
      //       id: "2",
      //       organizationId: 1,
      //       name: "Chiko | NEET",
      //       slug: 'NEET',
      //       description: "NEET description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1600.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Exam(
      //       id: "3",
      //       organizationId: 1,
      //       name: "Chiko | Class 12 Chemistry",
      //       slug: 'Class 12 Chemistry',
      //       description: "Class 12 Chemistry description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1700.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //   ];
      //   final data = res.data['data'];
      //   if (data is List) {
      //     for (var element in data) {
      //       final model = Exam.fromJson(element);
      //       Exams.add(model);
      //     }
      //   }
      //   return Exams;
      // } else {
      //   final msg = res.data['message'] ?? "Unknown error occured";
      //   showErrorDialog(msg);
      //   return null;
      // }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg, "getPopularExams dummy");
      return null;
    }
  }

  void getFeaturedExams() async {
    try {
      // log("Coming to get Featured Exams");
      // final data = [
      //   Exam(
      //     id: 5,
      //     organizationId: 1,
      //     name: "NEET Mock Test | Zirlaite Puitu",
      //     slug: 'NEET',
      //     description: "NEET description",
      //     mode: "mode",
      //     contentsCount: 6,
      //     duration: 600,
      //     price: 1600.0,
      //     published: true,
      //     featured: true,
      //     imagePath: "https://picsum.photos/id/4/400/200",
      //     categoryId: 1,
      //     organization:
      //         Organization(id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //   ),
      //   Exam(
      //     id: 3,
      //     organizationId: 1,
      //     name: "Class 12 Chemistry | Zawlbuk Zirna Run",
      //     slug: 'Class 12 Chemistry',
      //     description: "Class 12 Chemistry description",
      //     mode: "mode",
      //     contentsCount: 6,
      //     duration: 600,
      //     price: 1700.0,
      //     published: true,
      //     featured: true,
      //     imagePath: "https://picsum.photos/id/5/400/200",
      //     categoryId: 1,
      //     organization:
      //         Organization(id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //   ),
      //   Exam(
      //     id: 1,
      //     organizationId: 1,
      //     name: "JEE Mock Test 3 | Chiko",
      //     slug: 'JEE',
      //     description: "JEE Mains description",
      //     mode: "mode",
      //     contentsCount: 6,
      //     duration: 600,
      //     price: 1500.0,
      //     published: true,
      //     featured: true,
      //     imagePath: "https://picsum.photos/id/6/400/200",
      //     categoryId: 1,
      //     organization: Organization(
      //       id: 1,
      //       name: "Chiko Tuition Centre",
      //       slug: "slug",
      //     ),
      //   ),
      // ];
      // GetStorageController().to.saveFeaturedExams(data);

      // final params = filter.putIfAbsent("page", () => pageNo);
      // final res = await dio.getUri(Uri(
      //   scheme: 'https',
      //   host: 'api.onepercent.com',
      //   path: Strings.ExamsUrl,
      //   queryParameters: params,
      // ));
      // if (res.statusCode == 200) {
      //   final List<Exam> Exams = [
      //     Exam(
      //       id: 1,
      //       organizationId: 1,
      //       name: "Chiko | JEE",
      //       slug: 'JEE',
      //       description: "JEE Mains description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1500.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Exam(
      //       id: "2",
      //       organizationId: 1,
      //       name: "Chiko | NEET",
      //       slug: 'NEET',
      //       description: "NEET description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1600.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //     Exam(
      //       id: "3",
      //       organizationId: 1,
      //       name: "Chiko | Class 12 Chemistry",
      //       slug: 'Class 12 Chemistry',
      //       description: "Class 12 Chemistry description",
      //       mode: "mode",
      //       contentsCount: 6,
      //       duration: 600,
      //       price: 1700.0,
      //       published: true,
      //       featured: true,
      //       imagePath: null,
      //       categoryId: 1,
      //       organization: Organization(
      //           id: 1, name: "Chiko Tuition Centre", slug: "slug"),
      //     ),
      //   ];
      //   final data = res.data['data'];
      //   if (data is List) {
      //     for (var element in data) {
      //       final model = Exam.fromJson(element);
      //       Exams.add(model);
      //     }
      //   }
      //   return Exams;
      // } else {
      //   final msg = res.data['message'] ?? "Unknown error occured";
      //   showErrorDialog(msg);
      //   return null;
      // }
    } catch (e) {
      log("GET Error:$e");
      final msg = e.toString();
      showErrorDialog(msg, "getFeaturedExams dummy2");
      return null;
    }
  }
}
