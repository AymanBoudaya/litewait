import 'package:caferesto/utils/device/device_utility.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      TPrimaryHeaderContainer(
          child: Column(children: [
        THomeAppBar(),
        const SizedBox(height: TSizes.spaceBtwSections),

        /// SearchBar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          child: Container(
            width: TDeviceUtils.getScreenWidth(context),
            padding: const EdgeInsets.all(TSizes.md),
            decoration: BoxDecoration(
              color: TColors.white,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              border: Border.all(color: TColors.grey),
            ),
            child: Row(
              children: [
                const Icon(
                  Iconsax.search_normal,
                  color: TColors.darkerGrey,
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text('Rechercher dans les restaurants',
                    style: Theme.of(context).textTheme.bodySmall!.apply(color: TColors.darkerGrey)),
              ],
            ),
          ),
        ),
      ]))
    ])));
  }
}
