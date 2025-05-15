import 'package:caferesto/common/widgets/images/t_rounded_image.dart';
import 'package:caferesto/utils/constants/colors.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:caferesto/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TAppBar(showBackArrow: true,
            title: Text('Panier',
                style: Theme.of(context).textTheme.headlineSmall)),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ListView.separated(
              itemBuilder:  (_, index) => 
              Column(
                children: [
                  Row(
                    children: [
                      /// Image
                      TRoundedImage(imageUrl: TImages.productImage1, width: 60, height: 60, padding: EdgeInsets.all(TSizes.sm), backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.light,)
                    ],
                  )
                ],
              ),
              separatorBuilder: (_, __) =>
                  const SizedBox(height: TSizes.spaceBtwSections),
              itemCount: 4),
        )));
  }
}
