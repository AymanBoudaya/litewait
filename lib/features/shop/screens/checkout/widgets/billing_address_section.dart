import 'package:caferesto/common/widgets/texts/section_heading.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Adresse de livraison',
          buttonTitle: 'Changer',
          onPressed: () {},
        ),
        Text(
          'ALi karray',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              '+216-55 21 52 36',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Expanded(
              child: Text(
                'Gremda km 10, Sfax, Tunisie',
                style: Theme.of(context).textTheme.bodyMedium,
                softWrap: true,
              ),
            )
          ],
        ),
      ],
    );
  }
}
