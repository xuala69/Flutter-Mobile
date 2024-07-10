import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prep_pro/ui/home/Tests/SingleTest/widgets/questions_ui.dart';
import 'package:prep_pro/ui/widgets/m_appbar.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/numbers_function.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';
import 'test_detail_ui_controller.dart';
import 'widgets/test_intro_summary.dart';

class TestDetailPage extends StatefulWidget {
  final int testId;
  final String testSlug;
  const TestDetailPage(
      {required this.testId, required this.testSlug, super.key});

  @override
  State<TestDetailPage> createState() => _TestDetailPageState();
}

class _TestDetailPageState extends State<TestDetailPage> {
  final uiCtrl = Get.put(TestDetailUIController());

  @override
  void initState() {
    TestDetailUIController().to.getTest(widget.testSlug);
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
                ? testDetails()
                : QuestionsUI()),
      ),
    );
  }

  Widget testDetails() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      children: [
        Container(
          color: Colors.grey[200],
          height: MediaQuery.of(context).size.width * 0.5,
          child: CachedNetworkImage(
            imageUrl: getImageUrl(uiCtrl.test.value?.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        vs(15),
        Text(
          uiCtrl.test.value?.name ?? "",
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
              uiCtrl.test.value?.organization?.name ?? "N/A",
            ),
          ],
        ),
        vs(5),
        Row(
          children: [
            Icon(
              MdiIcons.certificateOutline,
              size: 25,
            ),
            hs(10),
            Text(
              uiCtrl.test.value?.category?.name ?? "N/A",
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
            Text("${uiCtrl.test.value!.durationInDays} days"),
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
                  getExcerpt(uiCtrl.test.value?.description),
                  style: GoogleFonts.spectral(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                );
              } else {
                return HtmlWidget(
                  uiCtrl.test.value?.description ?? "",
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
        // HtmlWidget(
        //   uiCtrl.test.value?.description ?? "",
        //   textStyle: const TextStyle(
        //     fontSize: 16,
        //   ),
        // ),
        vs(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (uiCtrl.test.value!.mode.toLowerCase() == "free")
              Text(
                "FREE",
                style: GoogleFonts.spectral(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            if (uiCtrl.test.value!.mode.toLowerCase() != "free")
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
        if (!canTest())
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
              final res = await Get.dialog(TestIntroSummary());
              if (res != null) {
                uiCtrl.startTest();
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
              "Start Test",
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

  bool canTest() {
    //TODO  test theih em check ngai
    return true;
  }
}
