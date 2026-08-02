// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class CustomImageWidget extends StatelessWidget {
//   final Widget Function(BuildContext)? placeholderBuilder;
//   final String imageUrl;
//   final double? width;
//   final double? height;
//   final BoxFit? fit;
//   final Color? color;
//   final bool isCarImage;
//   final LoadingErrorWidgetBuilder? errorWidget;
//   final FilterQuality? filterQuality;
//   final BlendMode? colorBlendMode;

//   const CustomImageWidget({
//     required this.imageUrl,
//     super.key,
//     this.width = 165,
//     this.height = 52,
//     this.fit = BoxFit.cover,
//     this.color,
//     this.placeholderBuilder,
//     this.isCarImage = false,
//     this.errorWidget,
//     this.filterQuality,
//     this.colorBlendMode,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (imageUrl.startsWith('http')) {
//       if (imageUrl.endsWith('svg')) {
//         return SvgPicture.network(
//           imageUrl,
//           width: width,
//           height: height,
//           fit: fit ?? BoxFit.contain,
//           colorFilter: color != null
//               ? ColorFilter.mode(color!, BlendMode.srcIn)
//               : null,
//           placeholderBuilder: placeholderBuilder,
//         );
//       } else {

//         return CachedNetworkImage(
//           imageUrl: imageUrl,
//           height: height,
//           width: width,
//           fit: fit,
//           filterQuality: filterQuality ?? FilterQuality.low,
//           colorBlendMode: colorBlendMode,
//           color: color,
//           placeholder: (context, url) => Skeletonizer(
//             child: Image.asset(
//               "assets/images/error.png",
//               width: width,
//               height: height,
//             ),
//           ),
//           errorWidget:
//               errorWidget ??
//               (context, url, error) => Image.asset(
//                 "assets/images/error.png",
//                 width: width,
//                 height: height,
//               ),
//         );
//       }
//     } else if (imageUrl.contains('.svg')) {
//       return SvgPicture.asset(
//         imageUrl,
//         semanticsLabel: 'Acme Logo',
//         width: width,
//         height: height,
//         fit: fit ?? BoxFit.contain,
//         colorFilter: color != null
//             ? ColorFilter.mode(color!, BlendMode.srcIn)
//             : null,
//       );
//     }
//     return Image.asset(
//       imageUrl,
//       width: width,
//       height: height,
//       fit: fit,
//       errorBuilder: (context, error, stackTrace) {
//         return Image.asset(
//           "assets/images/error.png",
//           width: width,
//           height: height,
//         );
//       },
//       color: color,
//     );
//   }
// }
