import 'package:get/get.dart';
import 'package:secure_application/secure_application.dart';

class ProtectionController extends GetxController {
  ProtectionController get to => Get.find();

  SecureApplicationController ctrl = SecureApplicationController(
    SecureApplicationState(
      authenticated: true,
      locked: false,
      secured: false,
    ),
  );

  void secureApp() {
    ctrl.secure();
  }

  void unSecureApp() {
    ctrl.open();
  }
}
