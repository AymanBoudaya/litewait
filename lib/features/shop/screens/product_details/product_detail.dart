import 'package:caferesto/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:caferesto/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import 'widgets/product_attributes.dart';
import 'widgets/product_detail_image_slider.dart';
import 'widgets/rating_share_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
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
                TProductAttributes()
                /// Checkout button
                /// Description
                /// Reviews
              ],
            ))
      ],
    )));
  }
}
