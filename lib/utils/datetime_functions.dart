import 'package:intl/intl.dart';

class DTFunctions {
  String savedAt(DateTime dt) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dt);

    if (difference.inDays < 1) {
      if (difference.inHours < 1) {
        return "${difference.inMinutes} minutes ago";
      } else {
        return "${difference.inHours} hours ago";
      }
    } else if (difference.inDays < 7) {
      return DateFormat('E, h:mm a').format(dt);
    } else if (difference.inDays >= 30) {
      return DateFormat('d MMM, yyyy').format(dt);
    } else {
      return DateFormat('E, h:mm a').format(dt);
    }
  }

  String getDate(String dt) {
    final parsed = DateFormat("yyyy-MM-dd").parse(dt);
    return DateFormat('d MMM, yyyy').format(parsed);
  }

  String formatDuration(int seconds) {
    final int days = seconds ~/ (24 * 3600);
    seconds %= (24 * 3600);
    final int hours = seconds ~/ 3600;
    seconds %= 3600;
    final int minutes = seconds ~/ 60;
    seconds %= 60;

    return '$days days : $hours hr : $minutes mins : $seconds secs';
  }
}
