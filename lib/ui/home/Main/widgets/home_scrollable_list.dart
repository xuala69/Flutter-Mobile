import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prep_pro/models/home_item.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/home_item_click.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';

import 'home_child_title.dart';

class ScrollableList extends StatelessWidget {
  const ScrollableList({
    super.key,
    required this.item,
  });

  final HomeItem item;

  @override
  Widget build(BuildContext context) {
    var totalItems = item.items.length;
    var row = totalItems >= 3 ? 3 : totalItems;
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: 220,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: row,
                childAspectRatio: 0.32,
                crossAxisSpacing: 0,
                mainAxisSpacing: 10,
              ),
              padding: EdgeInsets.only(
                left: Nums.paddingNormal,
                right: Nums.paddingNormal,
              ),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: item.items.length,
              itemBuilder: (context, index) {
                return _buildCard(context, item.items[index]);
              },
            ),
          ),
        ),
        vs(Nums.paddingNormal),
      ],
    );
  }

  Widget _buildCard(BuildContext context, Items item) {
    return InkWell(
      onTap: () {
        homeChildItemClick(context, item);
      },
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CachedNetworkImage(
              imageUrl: getImageUrl(item.imagePath),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.center,
                    image: imageProvider,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      Nums.searchbarRadius,
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.error_outline),
              ),
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(Nums.searchbarRadius),
                  ),
                ),
              ),
            ),
          ),
          hs(10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        (item.caption ?? ""),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                vs(2),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Text(
                //         (item.subTitle ?? ""),
                //         style: Theme.of(context).textTheme.titleSmall!.copyWith(
                //             fontSize: Constants.fontXS,
                //             color: Theme.of(context)
                //                 .textTheme
                //                 .bodyLarge!
                //                 .color!
                //                 .withOpacity(Constants.subTitleOpacity)),
                //         maxLines: 2,
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
