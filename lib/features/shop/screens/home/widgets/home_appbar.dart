import 'package:caferesto/features/personalization/controllers/user_controller.dart';
import 'package:caferesto/features/shop/screens/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../common/widgets/shimmer/shimmer_effect.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (controller.profileLoading.value) {
              return const TShimmerEffect(width: 80, height: 15);
            } else {
              return Text(TTexts.homeAppbarSubTitle,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: TColors.grey));
            }
          }),
          Obx(() {
            if (controller.profileLoading.value) {
              return const TShimmerEffect(width: 80, height: 15);
            } else {
              return Text(controller.user.value.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: TColors.grey));
            }
          }
          ),
        ],
      ),
      actions: [
        TCartCounterIcon(
            onPressed: () => Get.to(() => const CartScreen()),
            iconColor: TColors.white)
      ],
    );
  }
}
