import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:prep_pro/controllers/info_controller.dart';
import 'package:prep_pro/models/page.dart';
import 'package:prep_pro/ui/widgets/m_appbar.dart';
import 'package:prep_pro/utils/nums.dart';

class PageDetails extends StatelessWidget {
  final String slug;
  const PageDetails({required this.slug, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mAppbar(),
      body: FutureBuilder<InfoPage?>(
          future: InfoController().to.getPage(slug: slug),
          builder: (context, data) {
            if (data.hasData) {
              if (data.data != null) {
                final content = data.data!.contents;
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: Nums.paddingNormal,
                    vertical: Nums.paddingNormal,
                  ),
                  child: HtmlWidget(content),
                );
              }
              return const Center(
                child: Text("Error loading the data"),
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          }),
    );
  }
}
