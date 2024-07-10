import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/contents_controller.dart';
import 'package:prep_pro/models/content.dart';
import 'package:prep_pro/models/test.dart';
import 'package:prep_pro/ui/home/Course/ActualContent/content_buy_btn.dart';
import 'package:prep_pro/ui/home/Tests/widgets/test_grid.dart';
import 'package:prep_pro/ui/widgets/m_appbar.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';

class ActualContentRoot extends StatefulWidget {
  final Content content;
  const ActualContentRoot({
    required this.content,
    super.key,
  });

  @override
  State<ActualContentRoot> createState() => _ActualContentRootState();
}

class _ActualContentRootState extends State<ActualContentRoot> {
  final contentCtrl = ContentsController().to;

  final RxList<Test> tests = RxList<Test>();
  RxBool loading = true.obs;
  @override
  void initState() {
    contentCtrl
        .getContentTests(contentId: widget.content.id.toString())
        .then((result) {
      tests.addAll(result ?? []);
      loading.value = false;
    });
    super.initState();
  }

  void getTests() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mAppbar(),
      body: contentBody(context),
    );
  }

  Widget contentBody(BuildContext context) {
    return SingleChildScrollView(
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
              imageUrl: getImageUrl(widget.content.filePath),
            ),
          ),
          Text(
            widget.content.name,
            style: GoogleFonts.spectral(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          vs(5),
          Row(
            children: [
              Text(
                "Expiry :",
                style: GoogleFonts.spectral(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              hs(5),
              Text(
                "${widget.content.duration} days after purchase",
                style: GoogleFonts.spectral(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Type :",
                style: GoogleFonts.spectral(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              hs(5),
              Text(
                typeString(widget.content.type.toLowerCase()),
                style: GoogleFonts.spectral(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          HtmlWidget(
            widget.content.description ?? "",
          ),
          vs(10),
          ContentBuyButton(content: widget.content),
          vs(15),
          Text(
            "Mock Tests:",
            style: GoogleFonts.spectral(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Obx(() {
            if (loading.isTrue) {
              return SizedBox(
                height: Get.height * 0.4,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            } else {
              if (tests.isEmpty) {
                return SizedBox(
                  height: Get.height * 0.4,
                  child: Center(
                    child: Text(
                      "No Mock Tests available for this Content",
                      style: GoogleFonts.spectral(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                );
              }
              return GridView.builder(
                itemCount: tests.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 220,
                  mainAxisSpacing: Nums.paddingSmall,
                  crossAxisSpacing: Nums.paddingSmall,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = tests[index];
                  return TestGrid(
                    test: item,
                  );
                },
              );
            }
          }),

          // Obx(() {
          //   if (isContentPlayable(widget.content)) {
          //     return const Text("Play tests");
          //   } else {
          //     return vs(0);
          //   }
          // })
        ],
      ),
    );
  }

  String typeString(String type) {
    if (type.contains("video")) {
      return "Video";
    } else {
      return "Textual";
    }
  }
}
