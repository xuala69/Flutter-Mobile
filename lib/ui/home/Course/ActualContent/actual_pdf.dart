import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:prep_pro/controllers/protection_controller.dart';

class ActualPdf extends StatefulWidget {
  final String link;
  const ActualPdf({required this.link, super.key});

  @override
  State<ActualPdf> createState() => _ActualPdfState();
}

class _ActualPdfState extends State<ActualPdf> {
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
      body: const PDF().cachedFromUrl(
        widget.link,
        placeholder: (progress) => Center(
          child: Text('$progress %'),
        ),
        errorWidget: (error) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
