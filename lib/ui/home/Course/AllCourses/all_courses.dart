import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/models/course.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../controllers/courses_controller.dart';
import '../../../widgets/spacing.dart';
import '../widgets/course_tile.dart';

class HomeCoursesPage extends StatefulWidget {
  const HomeCoursesPage({super.key});

  @override
  State<HomeCoursesPage> createState() => _HomeCoursesPageState();
}

class _HomeCoursesPageState extends State<HomeCoursesPage> {
  static const _pageSize = 20;
  final ctrl = Get.put(CoursesController());

  final PagingController<int, Course> _pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    log("init called");
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      log("Fetch page :$pageKey");
      final newItems =
          await CoursesController().to.getCourses(pageNo: pageKey, filter: {});
      if (newItems == null) {
        return;
      }
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        vs(15),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              hs(15),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    fillColor: Colors.grey[200],
                    hintText: 'Search Course',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: Nums.paddingHigh,
                      right: Nums.paddingHigh,
                      bottom: 5,
                    ),
                  ),
                  cursorColor: Colors.transparent,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
              hs(10),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.sort_sharp),
              ),
              hs(15),
            ],
          ),
        ),
        Expanded(
          child: PagedListView<int, Course>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Course>(
              itemBuilder: (context, item, index) {
                return CourseListTile(
                  course: item,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
