import 'package:cached_network_image/cached_network_image.dart';
import 'package:caferesto/common/widgets/brands/brand_card.dart';
import 'package:caferesto/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:caferesto/common/widgets/shimmer/shimmer_effect.dart';
import 'package:caferesto/features/shop/models/brand_model.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:caferesto/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';
import '../../../features/shop/screens/brand/brand_products.dart';

class BrandShowcase extends StatelessWidget {
  const BrandShowcase({
    super.key,
    required this.images, required this.brand,
  });

final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>Get.to(() => BrandProducts(brand: brand)),
      child: TRoundedContainer(
          showBorder: true,
          borderColor: TColors.darkGrey,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(TSizes.md),
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Column(
            children: [
              /// Brand with products count
              BrandCard(
                showBorder: false,
                brand: brand ,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
      
      
              /// Brand top 3 products Images
              Row(
                children: images
                    .map((image) => brandTopProductImageWidget(image, context))
                    .toList(),
              )
            ],
          )),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkerGrey
            : TColors.light,
        margin: const EdgeInsets.only(right: TSizes.sm),
        padding: const EdgeInsets.all(TSizes.md),
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const TShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
