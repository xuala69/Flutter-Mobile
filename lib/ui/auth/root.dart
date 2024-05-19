import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';
import '../home/home_root.dart';
import 'login.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final controller = UserController().to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (controller.user.value == null) {
        return const LoginPage();
      } else {
        return const HomeRootPage();
      }
    }));
  }
}
