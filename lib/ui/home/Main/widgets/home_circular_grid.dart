import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/models/home_item.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/home_item_click.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';

import 'home_child_title.dart';

class HomeCircularGrid extends StatelessWidget {
  const HomeCircularGrid({
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
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.75,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          shrinkWrap: true,
          itemCount: item.items.length,
          padding: EdgeInsets.only(
              left: Nums.paddingNormal,
              right: Nums.paddingNormal,
              top: Nums.paddingNormal),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                homeChildItemClick(context, item.items[index]);
              },
              child: Column(
                children: [
                  Container(
                    width: Get.width * 0.4,
                    height: Get.width * 0.4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
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
                  if (item.items[index].caption != null &&
                      item.items[index].caption != "")
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.items[index].caption!,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 12,
                                    ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
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
