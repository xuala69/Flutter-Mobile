import 'package:flutter/material.dart';

import 'colors.dart';

Color cardColor(int index) {
  switch (index) {
    case 0:
      return AppColors.lightBlue;
    case 1:
      return AppColors.lightGreen;
    case 2:
      return AppColors.lightPink;
    case 3:
      return AppColors.lightPurple;
    case 4:
      return AppColors.lightOrange;
    default:
      return AppColors.lightBlue;
  }
}
