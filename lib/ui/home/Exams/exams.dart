import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:prep_pro/controllers/categories_controller.dart';
import 'package:prep_pro/models/exams.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

import 'exams_ui_controller.dart';

class HomeExamsPage extends StatefulWidget {
  const HomeExamsPage({super.key});

  @override
  State<HomeExamsPage> createState() => _HomeExamsPageState();
}

class _HomeExamsPageState extends State<HomeExamsPage> {
  final categoriesCtrl = CategoriesController().to;
  final uiCtrl = Get.put(ExamsUIController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        vs(10),
        SizedBox(
          height: 40,
          child: Obx(
            () => ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Nums.paddingNormal),
              separatorBuilder: (context, index) {
                return hs(10);
              },
              itemCount: categoriesCtrl.categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = categoriesCtrl.categories[index];
                return Obx(
                  () => InkWell(
                    onTap: () {
                      categoriesCtrl.selectedCatId.value = item.id;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Nums.paddingSmall,
                      ),
                      decoration: BoxDecoration(
                        color: categoriesCtrl.selectedCatId.value == item.id
                            ? Colors.blue[200]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            Nums.searchbarRadius,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(item.name),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: PagedListView(
            padding: EdgeInsets.symmetric(
              horizontal: Nums.paddingNormal,
            ),
            pagingController: uiCtrl.pagingController,
            builderDelegate: PagedChildBuilderDelegate<Exam>(
              itemBuilder: (context, item, index) {
                return Card(
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.organization?.name ?? ""),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
