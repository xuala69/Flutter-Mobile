import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/models/home_item.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/home_functions.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';

class HomeCarouselWidget extends StatefulWidget {
  final List<Items> items;
  const HomeCarouselWidget({required this.items, super.key});

  @override
  State<HomeCarouselWidget> createState() => HomeCarouselWidgetState();
}

class HomeCarouselWidgetState extends State<HomeCarouselWidget> {
  int _current = 0;
  List<Items> items = [];

  @override
  initState() {
    items.addAll(widget.items);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.5,
      width: Get.width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          SizedBox.expand(
            child: CarouselSlider(
              items: items
                  .map((item) => InkWell(
                        onTap: () {
                          homeItemClicked(item);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                getImageUrl(item.imagePath),
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(Nums.searchbarRadius),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: false,
                disableCenter: true,
                viewportFraction: 1.0,
                aspectRatio: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Nums.searchbarRadius),
                bottomRight: Radius.circular(Nums.searchbarRadius),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: Nums.paddingNormal,
              vertical: Nums.paddingSmall,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        items[_current].caption ?? "",
                        style: GoogleFonts.spectralSc(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                hs(Nums.paddingNormal),
                if (items.length > 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: items.map((url) {
                      int index = items.indexOf(url);
                      return Container(
                        width: _current == index ? 12 : 7.0,
                        height: _current == index ? 12 : 7.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 2.0,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.grey),
                            color: Colors.white),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
