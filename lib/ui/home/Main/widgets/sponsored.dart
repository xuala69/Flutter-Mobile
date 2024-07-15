// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:prep_pro/ui/widgets/spacing.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HomeSponsored extends StatefulWidget {
//   const HomeSponsored({
//     super.key,
//     required this.item,
//   });

//   final HomePageItem item;

//   @override
//   State<HomeSponsored> createState() => _HomeSponsoredState();
// }

// class _HomeSponsoredState extends State<HomeSponsored>
//     with AutomaticKeepAliveClientMixin {
//   final ctrl = Get.put(SponsoredController());
//   List<FaknaModel>? _faknate;

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//     _getFakna();
//   }

//   void _getFakna() async {
//     var res = await ctrl.getFaknate();
//     if (mounted) {
//       setState(() {
//         _faknate = res;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return _faknate != null && _faknate!.isNotEmpty
//         ? Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding:
//                     const EdgeInsets.only(top: 15, left: Constants.horizonPadM),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Sponsored",
//                     style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                           fontSize: Constants.fontM,
//                           fontWeight: FontWeight.w500,
//                         ),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 10),
//                 height: 70,
//                 child: Row(
//                   children: [
//                     hs(Constants.horizonPadM),
//                     Expanded(
//                         child: _faknate!.isEmpty
//                             ? hs(10)
//                             : InkWell(
//                                 onTap: () {
//                                   if (_faknate![0].link != null) {
//                                     launchUrl(Uri.parse(_faknate![0].link!));
//                                   }
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: CachedNetworkImageProvider(
//                                         Constants.cdnUrl +
//                                             _faknate![0].imagePath,
//                                       ),
//                                       fit: BoxFit.cover,
//                                     ),
//                                     color: Colors.grey.withOpacity(0.5),
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(4)),
//                                   ),
//                                 ),
//                               )),
//                     hs(10),
//                     Expanded(
//                       child: _faknate!.length < 2
//                           ? hs(10)
//                           : InkWell(
//                               onTap: () {
//                                 if (_faknate![1].link != null) {
//                                   launchUrl(Uri.parse(_faknate![1].link!));
//                                 }
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: CachedNetworkImageProvider(
//                                       Constants.cdnUrl + _faknate![1].imagePath,
//                                     ),
//                                     fit: BoxFit.cover,
//                                   ),
//                                   color: Colors.grey.withOpacity(0.5),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(4)),
//                                 ),
//                               ),
//                             ),
//                     ),
//                     hs(10),
//                     Expanded(
//                       child: _faknate!.length < 3
//                           ? hs(10)
//                           : InkWell(
//                               onTap: () {
//                                 if (_faknate![2].link != null) {
//                                   launchUrl(Uri.parse(_faknate![2].link!));
//                                 }
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: CachedNetworkImageProvider(
//                                       Constants.cdnUrl + _faknate![2].imagePath,
//                                     ),
//                                     fit: BoxFit.cover,
//                                   ),
//                                   color: Colors.grey.withOpacity(0.5),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(4)),
//                                 ),
//                               ),
//                             ),
//                     ),
//                     hs(Constants.horizonPadM),
//                   ],
//                 ),
//               ),
//               vs(Constants.horizonPadS),
//             ],
//           )
//         : vs(0);
//   }
// }
