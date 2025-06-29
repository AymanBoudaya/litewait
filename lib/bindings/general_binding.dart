import 'package:caferesto/features/personalization/controllers/address_controller.dart';
import 'package:caferesto/features/shop/controllers/product/checkout_controller.dart';
import 'package:caferesto/features/shop/controllers/product/variation_controller.dart';
import 'package:caferesto/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());

  }
}
