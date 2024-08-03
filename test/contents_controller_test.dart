import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart' hide Response;
import 'package:mockito/mockito.dart';
import 'package:prep_pro/controllers/contents_controller.dart';
import 'package:prep_pro/controllers/dio_controller.dart';

// Mock classes
class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  group('ContentsController', () {
    late ContentsController controller;
    late MockDio mockDio;
    late MockResponse mockResponse;

    setUp(() {
      mockDio = MockDio();
      mockResponse = MockResponse();
      // Initialize the controller with the mock Dio instance
      final dioController = DioController();
      dioController.dio = mockDio;
      Get.put(dioController);
      controller = ContentsController();
    });

    test('getContents returns list of Content on success', () async {
      final contentJson = [
        {
          "id": 1,
          "course_id": 1,
          "name": "JEE Hero",
          "slug": 'jee-hero',
          "type": "Text",
          "mode": "Free",
          "duration": 30,
          "price": 300.00,
          "published": true,
          "video_link": null,
          "file_path": null,
          "content": "JEE Hero nih dan description",
          "description": "Want to be a JEE Hero?",
        },
        {
          "id": 2,
          "course_id": 2,
          "name": "NEET HEro",
          "slug": 'neet-hero',
          "type": "Text",
          "mode": "Free",
          "duration": 30,
          "price": 250.00,
          "published": true,
          "video_link": null,
          "file_path": null,
          "content": "NEET Hero contents",
          "description": "Want to be a NEET Hero?",
        }
      ];
      final responseJson = jsonEncode({"data": contentJson});
      final responseMap = jsonDecode(responseJson);

      when(mockResponse.statusCode).thenReturn(200);
      when(mockResponse.data).thenReturn(responseMap);
      // when(mockDio.get('any')).thenAnswer((_) async {
      //   return mockResponse;
      // });
      // when(mockDio.get(any)).thenAnswer((_) async => mockResponse);

      final contents = await controller.getContents(courseId: 1);

      expect(contents, isNotNull);
      expect(contents?.length, 2);
      expect(contents?.first.name, "JEE Hero");
    });

    test('getContents shows error dialog on failure', () async {
      when(mockResponse.statusCode).thenReturn(400);
      when(mockResponse.data).thenReturn({"message": "Error occured"});
      when(mockDio.get('any')).thenAnswer((_) async => mockResponse);

      final contents = await controller.getContents(courseId: 1);

      expect(contents, isNull);
    });

    test('getPopularCourses returns null on error', () async {
      when(mockResponse.statusCode).thenReturn(400);
      when(mockResponse.data).thenReturn({"message": "Error occurred"});
      when(mockDio.get('any', data: anyNamed('data')))
          .thenAnswer((_) async => mockResponse);

      final result = controller.getPopularCourses();

      expect(result, isNull);
    });
  });
}
