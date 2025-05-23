import 'package:caferesto/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:caferesto/common/widgets/layouts/grid_layout.dart';
import 'package:caferesto/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:caferesto/common/widgets/brands/brand_card.dart';
import 'package:caferesto/common/widgets/texts/section_heading.dart';
import 'package:caferesto/features/shop/screens/brand/all_brands.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:caferesto/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../utils/constants/colors.dart';
import 'widgets/category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
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
                            text: 'Rechercher un produit',
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
                            onPressed: () => Get.to(()=> const AllBrandsScreen()),
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
                  CategoryTab(),
                  CategoryTab(),
                  CategoryTab(),
                  CategoryTab(),
                  CategoryTab(),
                  CategoryTab(),
                ],
              ))),
    );
  }
}
