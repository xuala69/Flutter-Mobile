import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/ui/widgets/m_appbar.dart';

import 'exam_detail_ui_controller.dart';

class ExamDetailPage extends StatelessWidget {
  final String examId;
  ExamDetailPage({required this.examId, super.key});

  final uiCtrl = Get.put(ExamDetailUIController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mAppbar(),
      body: Obx(
        () => uiCtrl.loading.value
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Column(
                children: [
                  Text(
                    uiCtrl.exam.value!.name,
                  )
                ],
              ),
      ),
    );
  }
}
