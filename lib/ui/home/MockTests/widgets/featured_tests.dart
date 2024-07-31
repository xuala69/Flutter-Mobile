// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prep_pro/controllers/tests_controller.dart';
// import 'package:prep_pro/ui/home/Main/widgets/tests_carousel.dart';
// import 'package:prep_pro/ui/widgets/spacing.dart';

// class FeaturedTestsGrid extends StatelessWidget {
//   FeaturedTestsGrid({super.key});
//   final testsCtrl = TestsController().to;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           "Featured Tests",
//           style: GoogleFonts.spectral(
//             fontSize: 18,
//             color: Colors.grey[900],
//           ),
//           textAlign: TextAlign.start,
//         ),
//         Obx(
//           () {
//             if (testsCtrl.featuredTests.isEmpty) {
//               return vs(0);
//             } else {
//               return TestsCarouselWidget(
//                 tests: testsCtrl.featuredTests,
//                 onTap: (p0) {
//                   //TODO goto new page
//                 },
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
