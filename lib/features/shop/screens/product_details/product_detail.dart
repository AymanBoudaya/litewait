import 'package:caferesto/common/widgets/texts/section_heading.dart';
import 'package:caferesto/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:caferesto/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import 'widgets/bottom_add_to_cart_widget.dart';
import 'widgets/product_attributes.dart';
import 'widgets/product_detail_image_slider.dart';
import 'widgets/rating_share_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: TBottomAddToCart(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            /// Product Image Slider
            TProductImageSlider(),

            /// Product Details
            Padding(
                padding: EdgeInsets.only(
                    right: TSizes.defaultSpace,
                    left: TSizes.defaultSpace,
                    bottom: TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// Rating and share
                    TRatingAndShare(),

                    /// Price title stock and brand
                    TProductMetaData(),

                    /// Attributes
                    TProductAttributes(),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    /// Checkout button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Cmandi -  كماندي')),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    /// Description
                    const TSectionHeading(
                      title: 'Description',
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    ReadMoreText(
                      'Une description du produit qui contient plusieurs lignes. ligne 1 ligne 2 ligne 3 ligne 12 packages have newer versions incompatible with dependency constraints.',
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Voir plus',
                      trimExpandedText: 'Moins',
                      moreStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800),
                    ),

                    /// Reviews
                    const Divider(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TSectionHeading(
                          title: 'Reviews(199)',
                          showActionButton: false,
                        ),
                        IconButton(
                          icon: const Icon(Iconsax.arrow_right, size: 18),
                          onPressed: () =>
                              Get.to(() => const ProductReviewsScreen()),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                  ],
                ))
          ],
        )));
  }
}
