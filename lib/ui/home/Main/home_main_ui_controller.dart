import 'dart:convert';
import 'package:get/get.dart';
import 'package:prep_pro/controllers/dio_controller.dart';
import 'package:prep_pro/controllers/get_storage_controller.dart';
import 'package:prep_pro/models/home_item.dart';
import 'package:prep_pro/utils/strings.dart';

class HomeUIController extends GetxController {
  HomeUIController get to => Get.find();

  final dio = DioController().to;
  RxBool loading = true.obs;
  List<HomeItem> homeItems = [];

  @override
  void onReady() {
    getHomeItems();
    super.onReady();
  }

  void getHomeItems() async {
    final res = await dio.get(Endpoints.homeItems, {});
    if (res is List) {
      for (var element in res) {
        final model = HomeItem.fromJson(element);
        homeItems.add(model);
      }
      loading.value = false;
      final data = homeItems.map((e) => e.toJson()).toList();
      GetStorageController().to.saveHomeItems(jsonEncode(data));
    } else {
      // final data = GetStorageController().to.getHomeItems();
    }
  }
}
