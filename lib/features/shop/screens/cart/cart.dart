import 'package:caferesto/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:caferesto/features/shop/screens/checkout/checkout.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title:
              Text('Panier', style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),

          /// Items in cart
          child: TCartItems()),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            child: Text('Checkout 256.0 DT')),
      ),
    );
  }
}
