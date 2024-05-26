import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/controllers/categories_controller.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

class HomeExamsPage extends StatefulWidget {
  const HomeExamsPage({super.key});

  @override
  State<HomeExamsPage> createState() => _HomeExamsPageState();
}

class _HomeExamsPageState extends State<HomeExamsPage> {
  final categoriesCtrl = CategoriesController().to;

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
                    // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    // visualDensity: VisualDensity.compact,
                    // padding: EdgeInsets.zero,
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
          child: ListView(),
        ),
      ],
    );
  }
}
