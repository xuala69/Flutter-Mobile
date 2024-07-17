import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prep_pro/controllers/get_storage_controller.dart';
import 'package:prep_pro/controllers/user_controller.dart';
import 'package:secure_application/secure_application.dart';

import 'controllers/categories_controller.dart';
import 'controllers/courses_controller.dart';
import 'controllers/dio_controller.dart';
import 'controllers/protection_controller.dart';
import 'controllers/tests_controller.dart';
import 'controllers/info_controller.dart';
import 'controllers/organizations_controller.dart';
import 'controllers/subjects_controller.dart';
import 'ui/auth/root.dart';
import 'ui/home/Main/home_main_ui_controller.dart';

void main() async {
  await GetStorage.init();
  initControllers();
  runApp(const MyApp());
}

initControllers() {
  Get.put(GetStorageController(), permanent: true);
  Get.put(DioController());
  Get.put(InfoController(), permanent: true);
  Get.put(UserController(), permanent: true);
  Get.put(CategoriesController());
  Get.put(OrganizationsController());
  Get.put(SubjectsController());
  Get.put(CoursesController());
  Get.put(TestsController());
  Get.put(HomeUIController(), permanent: true);
  Get.put(ProtectionController(), permanent: true);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SecureApplication(
      secureApplicationController: ProtectionController().to.ctrl,
      nativeRemoveDelay: 800,
      onNeedUnlock: (secureApplicationController) async {
        secureApplicationController?.authSuccess(unlock: true);
        return null;
      },
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple[900]!,
          ),
          primaryColor: Colors.deepPurple[900]!,
          useMaterial3: true,
        ),
        home: const RootPage(),
      ),
    );
  }
}
