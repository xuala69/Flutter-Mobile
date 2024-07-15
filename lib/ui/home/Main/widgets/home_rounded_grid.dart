import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/models/home_item.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/home_item_click.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';

import 'home_child_title.dart';

class HomeRoundedGrid extends StatelessWidget {
  const HomeRoundedGrid({
    super.key,
    required this.item,
  });

  final HomeItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            hs(Nums.paddingNormal),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: HomeChildTitle(
                  title: item.caption ?? "",
                  action: hs(0),
                ),
              ),
            ),
            hs(Nums.paddingNormal),
          ],
        ),
        vs(Nums.paddingSmall),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.55,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: Nums.paddingNormal),
          itemCount: item.items.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                homeChildItemClick(context, item.items[index]);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width * 0.3,
                    height: Get.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          getImageUrl(item.items[index].imagePath),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (item.items[index].caption != null &&
                      item.items[index].caption != "")
                    vs(5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          (item.items[index].caption ?? ""),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 12,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        vs(Nums.paddingSmall),
      ],
    );
  }
}
