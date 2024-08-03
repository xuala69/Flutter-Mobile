import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/models/content.dart';
import 'package:prep_pro/models/course.dart';
import 'package:prep_pro/models/mock_test.dart';
import 'package:prep_pro/ui/widgets/function_widgets.dart';
import 'package:prep_pro/utils/strings.dart';

import 'rzp_controller.dart';

class PaymentController extends GetxController {
  PaymentController get to => Get.find();
  final dio = DioController().to;
  final rzp = Get.put(RzpController());

  buyCourse({required Course course}) async {
    try {
      final res = await dio.post(
        Endpoints.initializePayment,
        {
          "type": "course", //course, content, test
          "payable": course.id,
        },
      );
      if (res != null) {
        rzp.buyCourse(course, res);
        return true;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "initialize Payment");
        return false;
      }
    } catch (e) {
      final msg = e.toString();
      showErrorDialog(msg, "initialize Payment");
      return false;
    }
  }

  buyContent({required Content content}) async {
    try {
      final res = await dio.post(
        Endpoints.initializePayment,
        {
          "type": "content", //course, content, test
          "payable": content.id,
        },
      );
      if (res != null) {
        rzp.buyContent(content, res);
        return true;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "initialize Payment");
        return false;
      }
    } catch (e) {
      final msg = e.toString();
      showErrorDialog(msg, "initialize Payment");
      return false;
    }
  }

  buyTest({required MockTest test}) async {
    try {
      final res = await dio.post(
        Endpoints.initializePayment,
        {
          "type": "test", //course, content, test
          "payable": test.id,
        },
      );
      if (res != null) {
        rzp.buyTest(test, res);
        return true;
      } else {
        final msg = res.data['message'] ?? "Unknown error occured";
        showErrorDialog(msg, "initialize Payment");
        return false;
      }
    } catch (e) {
      final msg = e.toString();
      showErrorDialog(msg, "initialize Payment");
      return false;
    }
  }
}
