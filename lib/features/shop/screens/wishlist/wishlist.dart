import 'package:caferesto/common/widgets/appbar/appbar.dart';
import 'package:caferesto/common/widgets/icons/t_circular_icon.dart';
import 'package:caferesto/common/widgets/layouts/grid_layout.dart';
import 'package:caferesto/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:caferesto/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:caferesto/features/shop/controllers/product/favorites_controller.dart';
import 'package:caferesto/features/shop/screens/home/home.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:caferesto/utils/helpers/cloud_helper_functions.dart';
import 'package:caferesto/utils/loaders/animation_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../navigation_menu.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController.instance;
    return Scaffold(
        appBar: TAppBar(
          title: Text(
            'Favoris',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCircularIcon(
                icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen())),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    Obx(
                      () => FutureBuilder(
                          future: controller.favoriteProducts(),
                          builder: (context, snapshot) {
                            final emptyWidget = TAnimationLoaderWidget(
                                text: "La liste de favoris est vide !",
                                animation: TImages.productsIllustration,
                                showAction: true,
                                actionText: "Ajountons des favoris !",
                                onActionPressed: () =>
                                    Get.off(() => const NavigationMenu()));

                            const loader =
                                TVerticalProductShimmer(itemCount: 6);
                            final widget =
                                TCloudHelperFunctions.checkMultiRecordState(
                                    snapshot: snapshot,
                                    loader: loader,
                                    nothingFound: emptyWidget);
                            if (widget != null) return widget;

                            final products = snapshot.data!;
                            return GridLayout(
                                itemCount: products.length,
                                itemBuilder: (_, index) => TProductCardVertical(
                                      product: products[index],
                                    ));
                          }),
                    )
                  ],
                ))));
  }
}
