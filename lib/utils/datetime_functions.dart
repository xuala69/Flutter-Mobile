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
}
