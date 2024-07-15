import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/models/content.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/course_content_functions.dart';
import 'package:prep_pro/utils/numbers_function.dart';
import 'package:prep_pro/utils/nums.dart';
import 'package:prep_pro/utils/string_functions.dart';
import '../../ActualContent/actual_content_root.dart';

class ContentListTile extends StatelessWidget {
  final Content content;
  final int index;
  const ContentListTile({
    required this.index,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Get.to(
          () => ActualContentRoot(
            content: content,
          ),
        );
      },
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: Nums.contentImageSize,
                height: Nums.contentImageSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      Nums.searchbarRadius,
                    ),
                  ),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      getImageUrl(
                        content.filePath,
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.grey[300],
                ),
              ),
              hs(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      content.name,
                      style: GoogleFonts.spectral(
                        fontSize: 16,
                        color: Colors.grey[900],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 17,
                          color: Colors.grey[600],
                        ),
                        hs(5),
                        Text(
                          "${content.duration} days",
                          style: GoogleFonts.spectral(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    if (contentFree(content.mode))
                      Text(
                        "Free",
                        style: GoogleFonts.spectral(
                          fontSize: 18,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    else
                      Text(
                        formatToIndianRupees(content.price),
                        style: GoogleFonts.spectral(
                          fontSize: 18,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
