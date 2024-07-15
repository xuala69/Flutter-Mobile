import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prep_pro/models/home_item.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/home_item_click.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';

import 'home_child_title.dart';

class HomeSquareGrid extends StatelessWidget {
  const HomeSquareGrid({
    super.key,
    required this.item,
  });

  final HomeItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HomeChildTitle(
          title: 'Square grid',
          action: hs(0),
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 16 / 10,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemCount: item.items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                homeChildItemClick(context, item.items[index]);
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      getImageUrl(item.items[index].imagePath),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
        vs(Nums.paddingNormal),
      ],
    );
  }
}
