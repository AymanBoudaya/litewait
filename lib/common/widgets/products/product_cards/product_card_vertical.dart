// ignore_for_file: deprecated_member_use

import 'package:caferesto/common/widgets/images/t_rounded_image.dart';
import 'package:caferesto/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:caferesto/features/shop/controllers/product/product_controller.dart';
import 'package:caferesto/utils/constants/colors.dart';
import 'package:caferesto/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/models/product_model.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/shadows.dart';
import '../../texts/brand_title_text_with_verified_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';
import 'widgets/add_to_cart_button.dart';
import 'widgets/rounded_container.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(
            product: product,
          )),
      child: Container(
          width: 180,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: dark ? TColors.darkerGrey : TColors.white,
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            boxShadow: [TShadowStyle.verticalProductShadow],
          ),
          child: Column(
            children: [
              /// Thumbnail
              TRoundedContainer(
                  height: 180,
                  width: 180,
                  padding: const EdgeInsets.all(TSizes.sm),
                  backgroundColor: dark ? TColors.dark : TColors.light,
                  child: Stack(
                    children: [
                      /// -- Thumbnail Image
                      TRoundedImage(
                        imageUrl: product.thumbnail,
                        applyImageRadius: true,
                      ),

                      /// Sale Tag
                      if (salePercentage != null)
                        Positioned(
                          top: 12,
                          child: TRoundedContainer(
                            radius: TSizes.sm,
                            backgroundColor: TColors.secondary.withOpacity(0.8),
                            padding: const EdgeInsets.symmetric(
                                vertical: TSizes.xs, horizontal: TSizes.sm),
                            child: Text(
                              '$salePercentage%',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .apply(color: TColors.black),
                            ),
                          ),
                        ),

                      /// -- Favorite Icon Button
                      Positioned(
                          top: 0,
                          right: 0,
                          child: FavoriteIcon(productId: product.id))
                    ],
                  )),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),

              /// Details
              Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      TProductTitleText(
                        title: product.title,
                        smallSize: true,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      BrandTitleWithVerifiedIcon(
                        title: product.brand!.name,
                      ),

                      /// Price Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Price
                          Flexible(
                            child: Column(
                              children: [
                                if (product.productType ==
                                        ProductType.single.toString() &&
                                    product.salePrice > 0)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: TSizes.sm),
                                    child: Text(
                                      product.price.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .apply(
                                            color: TColors.textSecondary,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                    ),
                                  ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: TSizes.sm),
                                  child: ProductPriceText(
                                    price: controller.getProductPrice(product),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Add To cart button
                          ProductCardAddToCartButton(product: product)
                        ],
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}
