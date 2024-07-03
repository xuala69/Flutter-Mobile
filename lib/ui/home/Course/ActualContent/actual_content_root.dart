import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/models/content.dart';
import 'package:prep_pro/ui/home/Course/ActualContent/content_buy_btn.dart';
import 'package:prep_pro/ui/widgets/m_appbar.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/datetime_functions.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';

class ActualContentRoot extends StatelessWidget {
  final Content content;
  const ActualContentRoot({
    required this.content,
    super.key,
  });

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
              imageUrl: getImageUrl(content.filePath),
            ),
          ),
          Text(
            content.name,
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
                "Duration :",
                style: GoogleFonts.spectral(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              hs(5),
              Text(
                DTFunctions().formatDuration(content.duration),
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
                typeString(content.type.toLowerCase()),
                style: GoogleFonts.spectral(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          HtmlWidget(
            content.description ?? "",
          ),
          vs(10),
          ContentBuyButton(content: content),
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
