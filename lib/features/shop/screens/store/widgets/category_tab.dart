import 'package:caferesto/common/widgets/layouts/grid_layout.dart';
import 'package:caferesto/common/widgets/texts/section_heading.dart';
import 'package:caferesto/features/shop/controllers/product/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Brands
                BrandShowcase(images: [
                  TImages.productImage1,
                  TImages.productImage2,
                  TImages.productImage3,
                ]),
                BrandShowcase(images: [
                  TImages.productImage1,
                  TImages.productImage2,
                  TImages.productImage3,
                ]),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                /// Products
                TSectionHeading(
                  title: "Vous aimez peut être",
                  onPressed: () {},
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                GridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) => TProductCardVertical(product: controller.featuredProducts[index]),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          ),
        ]);
  }
}
