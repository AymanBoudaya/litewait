import 'package:caferesto/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:caferesto/common/widgets/texts/product_price_text.dart';
import 'package:caferesto/common/widgets/texts/product_title_text.dart';
import 'package:caferesto/common/widgets/texts/section_heading.dart';
import 'package:caferesto/utils/constants/colors.dart';
import 'package:caferesto/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../utils/constants/sizes.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(children: [
      /// selected attribute pricing and description
      TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(children: [
            /// Title Price and Stock status
            Row(children: [
              TSectionHeading(
                title: 'Variation',
                showActionButton: false,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const TProductTitleText(
                        title: 'Prix : ',
                        smallSize: true,
                      ),

                      ///Actual price
                      Text(
                        '25 DT',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .apply(decoration: TextDecoration.lineThrough),
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),

                      ///Sale price
                      const ProductPriceText(price: "20")
                    ],
                  ),
                  Row(
                    children: [
                      const TProductTitleText(
                        title: 'Stock : ',
                        smallSize: true,
                      ),
                      Text('En Stock',
                          style: Theme.of(context).textTheme.titleMedium)
                    ],
                  )
                ],
              ),
            ]),

            /// Variation description
            const TProductTitleText(
              title:
                  'C\'est la description du produit et qui peut s\'étendre jusqu\'à 4 lignes au maximum',
              smallSize: true,
              maxLines: 4,
            )
          ])),
      const SizedBox(
        width: TSizes.spaceBtwItems,
      ),

      /// Attributes
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            children: [
              const TSectionHeading(
                title: 'Couleurs',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              TChoiceChip(
                text: 'Green',
                selected: true,
                onSelected: (value) {},
              ),
              TChoiceChip(
                text: 'Blue',
                selected: false,
                onSelected: (value) {},
              ),
              TChoiceChip(
                text: 'Yellow',
                selected: false,
                onSelected: (value) {},
              ),
              TChoiceChip(
                text: 'Green',
                selected: true,
                onSelected: (value) {},
              ),
              TChoiceChip(
                text: 'Blue',
                selected: false,
                onSelected: (value) {},
              ),
              TChoiceChip(
                text: 'Yellow',
                selected: false,
                onSelected: (value) {},
              ),
            ],
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TSectionHeading(
            title: 'Taille',
            showActionButton: false,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems / 2,
          ),
          Wrap(
            spacing: 8,
            children: [
              TChoiceChip(
                  text: 'EU 34', selected: true, onSelected: (value) {}),
              TChoiceChip(
                  text: 'EU 36', selected: false, onSelected: (value) {}),
              TChoiceChip(
                  text: 'EU 38', selected: false, onSelected: (value) {}),
            ],
          ),
        ],
      )
    ]);
  }
}
