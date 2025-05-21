import 'package:caferesto/common/widgets/appbar/appbar.dart';
import 'package:caferesto/common/widgets/brands/brand_card.dart';
import 'package:caferesto/common/widgets/layouts/grid_layout.dart';
import 'package:caferesto/common/widgets/texts/section_heading.dart';
import 'package:caferesto/features/shop/screens/brand/brand_products.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TAppBar(
          title: Text("Marque"),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Heading
                TSectionHeading(
                  title: 'Marques',
                  showActionButton: false,
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                /// Brands
                GridLayout(
                    itemCount: 10,
                    mainAxisExtent: 80,
                    itemBuilder: (context, index) => BrandCard(
                        showBorder: true,
                        onTap: () => Get.to(() => const BrandProducts())))
              ],
            ),
          ),
        ));
  }
}
