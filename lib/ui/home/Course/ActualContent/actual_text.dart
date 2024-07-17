import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:prep_pro/controllers/protection_controller.dart';
import 'package:prep_pro/utils/nums.dart';

class ActualText extends StatefulWidget {
  final String data;
  const ActualText({required this.data, super.key});

  @override
  State<ActualText> createState() => _ActualTextState();
}

class _ActualTextState extends State<ActualText> {
  @override
  void initState() {
    ProtectionController().to.secureApp();
    super.initState();
  }

  @override
  void dispose() {
    ProtectionController().to.unSecureApp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Nums.paddingNormal,
          vertical: Nums.paddingHigh,
        ),
        child: HtmlWidget(
          widget.data,
          textStyle: const TextStyle(
            fontSize: 20,
            fontFamily: "spectral",
          ),
        ),
      ),
    );
  }
}
