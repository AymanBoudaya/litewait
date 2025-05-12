import 'package:caferesto/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:caferesto/common/widgets/layouts/grid_layout.dart';
import 'package:caferesto/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:caferesto/common/widgets/products/product_cards/brand_card.dart';
import 'package:caferesto/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:caferesto/common/widgets/texts/section_heading.dart';
import 'package:caferesto/utils/constants/enums.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:caferesto/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/texts/brand_title_text_with_verified_icon.dart';
import '../../../../utils/constants/colors.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: TAppBar(
            title: Text(
              'Store',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            actions: [
              TCartCounterIcon(
                onPressed: () {},
              )
            ],
          ),
          body: NestedScrollView(

              /// Header
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: THelperFunctions.isDarkMode(context)
                        ? TColors.black
                        : TColors.white,
                    expandedHeight: 440,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          /// SearchBar
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          const TSearchContainer(
                            text: 'Rechercher dans le Store',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          /// Featured Brands
                          TSectionHeading(
                            title: 'Marques Populaires',
                            onPressed: () {},
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems / 1.5,
                          ),

                          GridLayout(
                              itemCount: 4,
                              mainAxisExtent: 80,
                              itemBuilder: (_, index) {
                                return BrandCard(showBorder: false);
                              }),
                        ],
                      ),
                    ),

                    /// TABS
                    bottom: Tabbar(tabs: [
                      Tab(child: Text("Café")),
                      Tab(child: Text("Sandwichs")),
                      Tab(child: Text("Pâtisseries")),
                      Tab(child: Text("Boissons")),
                      Tab(child: Text("Plats")),
                      Tab(child: Text("Pizzas")),
                    ]),
                  )
                ];
              },
              body: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// Brands
                        BrandShowcase()

                        /// Products
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}

class BrandShowcase extends StatelessWidget {
  const BrandShowcase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
        showBorder: true,
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(
            bottom: TSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Brand with products count
            const BrandCard(
              showBorder: false,
            ),
    
            /// Brand top 3 products Images
            Row(
              children: [
                Expanded(
                  child: TRoundedContainer(
                    height: 100,
                    backgroundColor:
                        THelperFunctions.isDarkMode(context)
                            ? TColors.darkerGrey
                            : TColors.light,
                    margin: const EdgeInsets.only(
                        right: TSizes.sm),
                    padding:
                        const EdgeInsets.all(TSizes.md),
                    child: Image(
                      image: const AssetImage(
                          TImages.productImage12),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: TRoundedContainer(
                    height: 100,
                    backgroundColor:
                        THelperFunctions.isDarkMode(context)
                            ? TColors.darkerGrey
                            : TColors.light,
                    margin: const EdgeInsets.only(
                        right: TSizes.sm),
                    padding:
                        const EdgeInsets.all(TSizes.md),
                    child: Image(
                      image: const AssetImage(
                          TImages.productImage12),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: TRoundedContainer(
                    height: 100,
                    backgroundColor:
                        THelperFunctions.isDarkMode(context)
                            ? TColors.darkerGrey
                            : TColors.light,
                    margin: const EdgeInsets.only(
                        right: TSizes.sm),
                    padding:
                        const EdgeInsets.all(TSizes.md),
                    child: Image(
                      image: const AssetImage(
                          TImages.productImage12),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
