import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/contents_controller.dart';
import 'package:prep_pro/ui/home/Course/SingleCoursePage/widgets/course_buy_button.dart';
import 'package:prep_pro/ui/widgets/m_appbar.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/datetime_functions.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';
import 'course_detail_ui_controller.dart';
import 'widgets/content_list_trailing.dart';

class CourseDetailPage extends StatefulWidget {
  final int courseId;
  final String courseSlug;
  const CourseDetailPage({
    required this.courseId,
    required this.courseSlug,
    super.key,
  });

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  final contentsCtrl = Get.put(ContentsController());
  final uiCtrl = Get.put(CourseDetailUIController());

  @override
  void initState() {
    uiCtrl.initiateController(
      newId: widget.courseId,
      slug: widget.courseSlug,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mAppbar(),
      body: Obx(
        () => uiCtrl.loading.isTrue
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : courseBody(),
      ),
    );
  }

  Widget bodyDetails() {
    return Obx(() {
      if (uiCtrl.tabIndex.value == 0) {
        return SingleChildScrollView(
          child: HtmlWidget(
            uiCtrl.course.value?.description ?? "",
            textStyle: const TextStyle(
              fontSize: 15,
            ),
          ),
        );
      } else {
        return contentsListView();
      }
    });
  }

  Widget courseBody() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Nums.paddingNormal,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.grey[200],
            height: MediaQuery.of(context).size.width * 0.5,
            child: CachedNetworkImage(
              imageUrl: getImageUrl(uiCtrl.course.value?.imagePath),
            ),
          ),
          Text(
            uiCtrl.course.value!.name,
            style: GoogleFonts.spectral(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Created by ",
                  style: GoogleFonts.spectral(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: uiCtrl.course.value?.organization?.name ?? "N/A",
                  style: GoogleFonts.spectral(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          vs(5),
          Row(
            children: [
              const Icon(
                Icons.access_time_outlined,
                size: 15,
              ),
              hs(5),
              Text(
                DTFunctions().getDate(uiCtrl.course.value!.createdAt),
                style: GoogleFonts.spectral(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          CourseBuyButton(
            course: uiCtrl.course.value!,
          ),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const RoundedRectangleBorder(),
                  onPressed: () {
                    uiCtrl.tabIndex.value = 0;
                  },
                  child: Column(
                    children: [
                      Obx(
                        () => Text(
                          "Details",
                          style: GoogleFonts.spectral(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: uiCtrl.tabIndex.value == 0
                                ? AppColors.primary
                                : Colors.black,
                          ),
                        ),
                      ),
                      vs(5),
                      Obx(
                        () => Container(
                          height: 0.5,
                          color: uiCtrl.tabIndex.value == 0
                              ? AppColors.primary
                              : Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    uiCtrl.tabIndex.value = 1;
                  },
                  child: Column(
                    children: [
                      Obx(
                        () => Text(
                          "Contents",
                          style: GoogleFonts.spectral(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: uiCtrl.tabIndex.value == 1
                                ? AppColors.primary
                                : Colors.black,
                          ),
                        ),
                      ),
                      vs(5),
                      Obx(
                        () => Container(
                          height: 0.5,
                          color: uiCtrl.tabIndex.value == 1
                              ? AppColors.primary
                              : Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: bodyDetails(),
          ),
        ],
      ),
    );
  }

  Widget contentsListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = uiCtrl.contents[index];
        return ContentListTile(
          index: index,
          content: item,
        );
      },
      itemCount: uiCtrl.contents.length,
    );
  }
}
