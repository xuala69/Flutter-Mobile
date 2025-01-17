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
    /// x hr, y min, z secs a value neih dan azir a lang
    final int days = seconds ~/ (24 * 3600);
    seconds %= (24 * 3600);
    final int hours = seconds ~/ 3600;
    seconds %= 3600;
    final int minutes = seconds ~/ 60;
    seconds %= 60;

    final List<String> parts = [];

    if (days > 0) parts.add('$days days');
    if (hours > 0) parts.add('$hours hr');
    if (minutes > 0) parts.add('$minutes mins');
    if (seconds > 0 || parts.isEmpty) parts.add('$seconds secs');

    return parts.join(' : ');
  }
}
