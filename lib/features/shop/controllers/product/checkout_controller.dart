import 'package:caferesto/common/widgets/texts/section_heading.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/payment_method_model.dart';
import '../../screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(
        name: 'Payement à la caisse', image: TImages.masterCard);
    super.onInit();
  }

  Future<void> selectPaymentMethod(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(TSizes.lg),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                          title: 'Selectionner une methode de payement',
                          showActionButton: false),
                      SizedBox(height: TSizes.spaceBtwSections),
                      TPaymentTile(
                          paymentMethod: PaymentMethodModel(
                              name: 'Payement à la caisse',
                              image: TImages.masterCard)),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      TPaymentTile(
                          paymentMethod: PaymentMethodModel(
                              name: 'Payement à la livraison',
                              image: TImages.masterCard)),
                      const SizedBox(height: TSizes.spaceBtwItems / 2),
                      TPaymentTile(
                          paymentMethod: PaymentMethodModel(
                              name: 'D17 ',
                              image: TImages.masterCard)),
                      const SizedBox(height: TSizes.spaceBtwSections),
                    ]))));
  }
}
