import 'dart:developer';

import 'package:intl/intl.dart';

String formatToIndianRupees(double amount) {
  // Format the amount with Indian currency format
  final formatter =
      NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 2);
  String formattedAmount = formatter.format(amount);

  // Check if the decimal part is .00
  if (formattedAmount.endsWith('.00')) {
    // Remove the decimal part if it's .00
    formattedAmount = formattedAmount.substring(0, formattedAmount.length - 3);
  }

  return formattedAmount;
}

double progressValue({
  required int currentValue,
  required int length,
}) {
  final done = ((currentValue + 1) / length);
  log("Progress:$done");
  return done;
}
