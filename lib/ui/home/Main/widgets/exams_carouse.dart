import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/models/tests.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

class TestsCarouselWidget extends StatefulWidget {
  final List<Test> exams;
  final Function(Test) onTap;
  const TestsCarouselWidget(
      {required this.onTap, required this.exams, super.key});

  @override
  State<TestsCarouselWidget> createState() => TestsCarouselWidgetState();
}

class TestsCarouselWidgetState extends State<TestsCarouselWidget> {
  int _current = 0;
  List<Test> exams = [];

  @override
  initState() {
    exams.addAll(widget.exams);
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
              items: exams
                  .map((item) => InkWell(
                        onTap: widget.onTap(item),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                item.imagePath ??
                                    "https://picsum.photos/id/1/200/300",
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
                        exams[_current].name,
                        style: GoogleFonts.spectralSc(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        exams[_current].organization!.name,
                        style: GoogleFonts.spectralSc(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                hs(Nums.paddingNormal),
                if (exams.length > 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: exams.map((url) {
                      int index = exams.indexOf(url);
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
