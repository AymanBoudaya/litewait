import 'package:caferesto/common/widgets/shimmer/shimmer_effect.dart';
import 'package:caferesto/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 80,
    this.height = 80,
    this.padding = TSizes.sm,
  });

  final BoxFit fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
          color: TColors.success,
          width: 2,
        ),
        color: backgroundColor ??
            (THelperFunctions.isDarkMode(context)
                ? TColors.black
                : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Center(
              child: isNetworkImage
                  ? CachedNetworkImage(
                      fit: fit,
                      color: overlayColor,
                      imageUrl: image,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const TShimmerEffect(
                                  width: 55, height: 55, radius: 55),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : Image(
                      fit: fit,
                      image: AssetImage(image) as ImageProvider,
                      color: overlayColor,
                    ))),
    );
  }
}
