import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prep_pro/controllers/get_storage_controller.dart';
import 'package:prep_pro/controllers/user_controller.dart';

import 'ui/auth/root.dart';

void main() async {
  await GetStorage.init();
  initControllers();
  runApp(const MyApp());
}

initControllers() {
  Get.put(GetStorageController(), permanent: true);
  Get.put(UserController(), permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        primaryColor: Colors.deepPurple[800],
        useMaterial3: true,
      ),
      home: const RootPage(),
    );
  }
}
