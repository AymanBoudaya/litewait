import 'package:caferesto/features/shop/screens/all_products/all_products.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../authentication/screens/home/widgets/home_categories.dart';
import 'widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Primary Header Container
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// SearchBar --
                  TSearchContainer(
                    text: 'Rechercher un produit',
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// Categories
                  Padding(
                    padding: EdgeInsets.only(
                      left: TSizes.defaultSpace,
                    ),
                    child: Column(
                      children: [
                        /// -- Heading
                        TSectionHeading(
                          title: 'Catégories Populaires',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        /// Categories List
                        THomeCategories()
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    /// --PromoSlider
                    const TPromoSlider(
                      banners: [
                        TImages.promoBanner1,
                        TImages.promoBanner2,
                        TImages.promoBanner3
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    /// -- Heading
                    TSectionHeading(
                      title: 'Produits Populaires',
                      onPressed: () => Get.to(() => const AllProducts()),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    /// Popular products
                    GridLayout(
                      itemCount: 10,
                      itemBuilder: (_, index) => const TProductCardVertical(),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
