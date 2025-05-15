import 'package:caferesto/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:caferesto/common/widgets/products/ratings/rating_indicator.dart';
import 'package:caferesto/utils/constants/colors.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/helpers/helper_functions.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(TImages.userProfileImage1),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text(
                  'Ali Salem',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        /// Review
        Row(
          children: [
            TRatingBarIndicator(rating: 4),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              '01 Oct 2023',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        const ReadMoreText(
          'Une description du produit qui contient plusieurs lignes. ligne 1 ligne 2 ligne 3 ligne 12 packages have newer versions incompatible with dependency constraints.',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Voir plus',
          trimExpandedText: 'Moins',
          moreStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primary),
          lessStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primary),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        // Company Review
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Padding(
            padding: EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ali Store",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "02 Nov, 2023",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                const ReadMoreText(
                  'Une description du produit qui contient plusieurs lignes. ligne 1 ligne 2 ligne 3 ligne 12 packages have newer versions incompatible with dependency constraints.',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Voir plus',
                  trimExpandedText: 'Moins',
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
