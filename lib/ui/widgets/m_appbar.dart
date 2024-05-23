import 'package:flutter/material.dart';

import '../../utils/nums.dart';

PreferredSize mAppbar({
  required String title,
  required Color bgColor,
  required String subtitle,
  String? image,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(Nums.appbarHeight),
    child: AppBar(),
  );
}
