import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:prep_pro/utils/nums.dart';

class ActualText extends StatelessWidget {
  final String data;
  const ActualText({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Nums.paddingNormal,
          vertical: Nums.paddingHigh,
        ),
        child: HtmlWidget(
          data,
          textStyle: const TextStyle(
            fontSize: 20,
            fontFamily: "spectral",
          ),
        ),
      ),
    );
  }
}
