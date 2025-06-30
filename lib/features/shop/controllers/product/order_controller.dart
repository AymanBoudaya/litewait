import 'package:caferesto/common/widgets/success_screen/success_screen.dart';
import 'package:caferesto/features/shop/controllers/product/cart_controller.dart';
import 'package:caferesto/features/shop/controllers/product/checkout_controller.dart';
import 'package:caferesto/utils/constants/image_strings.dart';
import 'package:caferesto/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController{
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Erreur', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing your order', TImages.pencilAnimation);

      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        return;
      }

      // Add details
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate : DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        // Set date as needed
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
   ); 

   // Save the order to firestore
      await orderRepository.saveOrder(order, userId);

      cartController.clearCart();

      Get.off(() => SuccessScreen(image: TImages.orderCompletedAnimation, title: 'Payment effectué !', subTitle: 'Votre commande est en cours de traitement', onPressed: () => Get.offAll(() => const NavigationMenu())));
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Erreur', message: e.toString());
    }
  }
  
}