import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/controllers/contents_controller.dart';
import 'package:prep_pro/models/content.dart';
import 'package:prep_pro/ui/widgets/dialogs/confirm_content_order.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';
import 'package:prep_pro/utils/numbers_function.dart';
import 'package:prep_pro/utils/nums.dart';

class SingleContentPage extends StatefulWidget {
  final String contentSlug;
  const SingleContentPage({
    required this.contentSlug,
    super.key,
  });

  @override
  State<SingleContentPage> createState() => _SingleContentPageState();
}

class _SingleContentPageState extends State<SingleContentPage> {
  final ctrl = ContentsController().to;
  Rxn<Content> pageContent = Rxn<Content>();
  RxBool loading = true.obs;

  @override
  void initState() {
    ctrl.getContent(slug: widget.contentSlug).then((value) {
      pageContent.value = value;
      loading.value = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => loading.isTrue
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : contentUI(),
      ),
    );
  }

  Widget contentUI() {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: Nums.paddingNormal,
      ),
      children: [
        // Container(
        //   color: Colors.grey[200],
        //   height: MediaQuery.of(context).size.width * 0.5,
        //   child: CachedNetworkImage(
        //     imageUrl: getImageUrl(pageContent.value?.imagePath),
        //   ),
        // ),
        // vs(15),
        Text(
          pageContent.value!.name,
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
                text: pageContent.value?.name ?? "N/A",
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
        // Row(
        //   children: [
        //     const Icon(
        //       Icons.access_time_outlined,
        //     ),
        //     hs(5),
        //     Text(
        //       DTFunctions().getDate(pageContent.value!.createdAt),
        //       style: GoogleFonts.spectral(
        //         fontSize: 16,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ],
        // ),
        vs(25),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Obx(() {
            //   if (uiCtrl.showExcerpt.isTrue) {
            //     return Text(
            //       getExcerpt(pageContent.value?.content),
            //       style: GoogleFonts.spectral(
            //         fontSize: 17,
            //         fontWeight: FontWeight.w500,
            //       ),
            //       textAlign: TextAlign.justify,
            //       maxLines: 5,
            //       overflow: TextOverflow.ellipsis,
            //     );
            //   } else {
            //     return HtmlWidget(
            //       pageContent.value?.content ?? "",
            //       textStyle: const TextStyle(
            //         fontSize: 16,
            //       ),
            //     );
            //   }
            // }),
            HtmlWidget(
              pageContent.value?.content ?? "",
              textStyle: const TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              formatToIndianRupees(pageContent.value!.price),
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
        MaterialButton(
          onPressed: () {
            Get.dialog(ContentOrderConfirmDialog(
              content: pageContent.value!,
            ));
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
            "Buy Now",
            style: GoogleFonts.spectral(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const Divider(),
        vs(10),
      ],
    );
  }
}
