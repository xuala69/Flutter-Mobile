import 'package:prep_pro/utils/strings.dart';
import 'package:html/parser.dart';

String getImageUrl(String? path) {
  if (path == null) {
    return Strings.emptyImage;
  } else if (path.contains("http")) {
    return path;
  } else {
    return Endpoints.baseUrl + Endpoints.storage + path;
  }
}

String getExcerpt(String? data) {
  if (data == null) {
    return "";
  }
  final stripped = parse(data);
  final txt = stripped.documentElement!.text;
  return txt;
}
