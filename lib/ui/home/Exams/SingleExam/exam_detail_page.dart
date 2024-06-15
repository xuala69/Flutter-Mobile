import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prep_pro/ui/widgets/m_appbar.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/datetime_functions.dart';
import 'package:prep_pro/utils/numbers_function.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';
import 'package:prep_pro/utils/strings.dart';

import 'exam_detail_ui_controller.dart';
import 'widgets/exam_intro_summary.dart';
import 'widgets/options_card.dart';
import 'widgets/progress_indicator.dart';

class ExamDetailPage extends StatefulWidget {
  final int examId;
  const ExamDetailPage({required this.examId, super.key});

  @override
  State<ExamDetailPage> createState() => _ExamDetailPageState();
}

class _ExamDetailPageState extends State<ExamDetailPage> {
  final uiCtrl = Get.put(ExamDetailUIController());

  @override
  void initState() {
    ExamDetailUIController().to.getExam(widget.examId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mAppbar(),
      body: Obx(
        () => uiCtrl.loading.value
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Obx(() => uiCtrl.currentStep.value == null
                ? examDetails()
                : questionsUI(context)),
      ),
    );
  }

  Widget examDetails() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      children: [
        Container(
          color: Colors.grey[200],
          height: MediaQuery.of(context).size.width * 0.5,
          child: CachedNetworkImage(
            imageUrl: uiCtrl.exam.value?.imagePath ?? Strings.avatarDefault,
          ),
        ),
        vs(15),
        Text(
          uiCtrl.exam.value?.name ?? "",
          style: GoogleFonts.spectral(
            fontSize: 25,
          ),
        ),
        vs(5),
        Row(
          children: [
            Icon(
              MdiIcons.officeBuilding,
              size: 25,
            ),
            hs(10),
            Text(
              uiCtrl.exam.value?.organization?.name ?? "N/A",
            ),
          ],
        ),
        vs(5),
        Row(
          children: [
            Icon(
              MdiIcons.certificateOutline,
            ),
            hs(10),
            Text(
              uiCtrl.exam.value?.category?.name ?? "N/A",
            ),
          ],
        ),
        vs(5),
        Row(
          children: [
            Icon(
              MdiIcons.timerOutline,
            ),
            hs(10),
            Text(
              DTFunctions().formatDuration(uiCtrl.exam.value!.duration),
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
                  getExcerpt(uiCtrl.exam.value?.description),
                  style: GoogleFonts.spectral(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                );
              } else {
                return HtmlWidget(
                  uiCtrl.exam.value?.description ?? "",
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
        HtmlWidget(
          uiCtrl.exam.value?.description ?? "",
          textStyle: const TextStyle(
            fontSize: 16,
          ),
        ),
        vs(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (uiCtrl.exam.value!.mode.toLowerCase() == "free")
              Text(
                "FREE",
                style: GoogleFonts.spectral(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            if (uiCtrl.exam.value!.mode.toLowerCase() != "free")
              Text(
                formatToIndianRupees(1200),
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
        vs(10),
        if (!canExam())
          MaterialButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Nums.searchbarRadius,
                ),
              ),
            ),
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Buy Now",
              style: GoogleFonts.spectral(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        else
          MaterialButton(
            onPressed: () async {
              final res = await Get.dialog(ExamIntroSummary());
              if (res != null) {
                uiCtrl.currentStep.value = 0;
                uiCtrl.setTimer(uiCtrl.exam.value!.duration);
                uiCtrl.startTimer();
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Nums.searchbarRadius,
                ),
              ),
            ),
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Start Exam",
              style: GoogleFonts.spectral(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        vs(10),
      ],
    );
  }

  Widget questionsUI(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ExamProgressIndicator(),
              Obx(
                () => HtmlWidget(
                  uiCtrl.questions[uiCtrl.currentStep.value!].name,
                ),
              ),
              vs(MediaQuery.of(context).size.height * 0.3)
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: OptionsCard(
            question: uiCtrl.questions[uiCtrl.currentStep.value!],
          ),
        ),
      ],
    );
  }

  bool canExam() {
    return true;
  }
}
