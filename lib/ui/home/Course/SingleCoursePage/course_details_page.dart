import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/contents_controller.dart';
import 'package:prep_pro/ui/home/Course/ActualContent/actual_content_root.dart';
import 'package:prep_pro/ui/home/Course/SingleCoursePage/course_buy_button.dart';
import 'package:prep_pro/ui/widgets/m_appbar.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/datetime_functions.dart';
import 'package:prep_pro/utils/numbers_function.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';
import 'course_detail_ui_controller.dart';

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
            : ui(),
      ),
    );
  }

  Widget ui() {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: Nums.paddingNormal,
      ),
      children: [
        Container(
          color: Colors.grey[200],
          height: MediaQuery.of(context).size.width * 0.5,
          child: CachedNetworkImage(
            imageUrl: getImageUrl(uiCtrl.course.value?.imagePath),
          ),
        ),
        vs(15),
        Text(
          uiCtrl.course.value!.name,
          style: GoogleFonts.spectral(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        vs(5),
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
            ),
            hs(5),
            Text(
              DTFunctions().getDate(uiCtrl.course.value!.createdAt),
              style: GoogleFonts.spectral(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
        vs(25),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (uiCtrl.showExcerpt.isTrue) {
                return Text(
                  getExcerpt(uiCtrl.course.value?.description),
                  style: GoogleFonts.spectral(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                );
              } else {
                return HtmlWidget(
                  uiCtrl.course.value?.description ?? "",
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                );
              }
            }),
            Row(
              children: [
                const Spacer(),
                MaterialButton(
                  onPressed: () {
                    uiCtrl.showExcerpt.value = !uiCtrl.showExcerpt.value;
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                  child: Obx(
                    () => Text(
                      uiCtrl.showExcerpt.isTrue ? "See more" : "See less",
                      style: GoogleFonts.spectral(
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              formatToIndianRupees(uiCtrl.course.value!.price),
              style: GoogleFonts.spectral(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            hs(10),
            Text(
              formatToIndianRupees(1200),
              style: GoogleFonts.spectral(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.red, // Strikethrough color
              ),
            ),
          ],
        ),
        vs(5),
        CourseBuyButton(
          course: uiCtrl.course.value!,
        ),
        const Divider(),
        vs(10),
        Text(
          "Contents",
          style: GoogleFonts.spectral(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${uiCtrl.contents.length} sections in this course",
                style: GoogleFonts.spectral(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              vs(10),
              ListView.builder(
                itemBuilder: (context, index) {
                  final item = uiCtrl.contents[index];
                  return MaterialButton(
                    onPressed: () {
                      Get.to(
                        () => ActualContentRoot(
                          content: item,
                        ),
                      );
                    },
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${index + 1}.",
                          style: GoogleFonts.spectral(
                            fontSize: 24,
                            color: Colors.grey[900],
                          ),
                        ),
                        hs(20),
                        Expanded(
                          child: Text(
                            item.name,
                            style: GoogleFonts.spectral(
                              fontSize: 16,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.play_circle_outline,
                          size: 30,
                        ),
                      ],
                    ),
                  );
                },
                itemCount: uiCtrl.contents.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        )
      ],
    );
  }
}