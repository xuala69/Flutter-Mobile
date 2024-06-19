import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ActualPdf extends StatelessWidget {
  final String link;
  const ActualPdf({required this.link, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const PDF().cachedFromUrl(
        link,
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
