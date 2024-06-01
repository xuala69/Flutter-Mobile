import 'package:flutter/material.dart';
import 'package:prep_pro/models/content.dart';
import 'package:prep_pro/ui/home/Courses/ActualContent/actual_text.dart';
import 'package:prep_pro/ui/home/Courses/ActualContent/actual_video.dart';
import 'package:prep_pro/ui/widgets/m_appbar.dart';

import 'actual_pdf.dart';

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
      body: bodyWidget(
        content.type,
      ),
    );
  }

  Widget bodyWidget(String type) {
    switch (type.toLowerCase()) {
      case "pdf":
        {
          return ActualPdf(
            link: content.filePath ?? "",
          );
        }
      case "video_link":
        {
          return ActualVideo(
            link: content.videoLink!,
          );
        }
      case "text":
        {
          return ActualText(
            data: content.content!,
          );
        }
      default:
        {
          return const Center(
            child: Text(
              "The course content type is invalid. Please report to administrator",
            ),
          );
        }
    }
  }
}
