import 'package:flutter/material.dart';
import 'package:prep_pro/ui/widgets/m_appbar.dart';

class ExamOngoingScreen extends StatelessWidget {
  const ExamOngoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mAppbar(),
      body: Container(
        height: 30,
        width: double.infinity,
        color: Colors.green,
      ),
    );
  }
}
