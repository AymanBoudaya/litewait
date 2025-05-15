import 'package:caferesto/common/widgets/appbar/appbar.dart';
import 'package:caferesto/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:caferesto/common/widgets/images/t_rounded_image.dart';
import 'package:caferesto/utils/constants/colors.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgeWidget(
        child: Container(
            color: dark ? TColors.darkGrey : TColors.light,
            child: Stack(
              children: [
                /// Main Large Image
                const SizedBox(
                    height: 400,
                    child: Padding(
                      padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                      child: Center(
                          child:
                              Image(image: AssetImage(TImages.productImage1))),
                    )),

                /// Image slider
                Positioned(
                  right: 0,
                  bottom: 30,
                  left: TSizes.defaultSpace,
                  child: SizedBox(
                    height: 80,
                    child: ListView.separated(
                      itemCount: 6,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (_, index) => TRoundedImage(
                        imageUrl: TImages.productImage3,
                        backgroundColor: dark ? TColors.dark : TColors.white,
                        width: 80,
                        border: Border.all(color: TColors.primary),
                        padding: const EdgeInsets.all(TSizes.sm),
                      ),
                      separatorBuilder: (_, __) => const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                    ),
                  ),
                ),

                /// Appbar icons
                TAppBar(
                  showBackArrow: true,
                  actions: [
                    /// Favorite Icon
                    TCircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                    const SizedBox(width: TSizes.defaultSpace),
                  ],
                )
              ],
            )));
  }
}
