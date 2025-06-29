import 'package:caferesto/features/shop/controllers/product/cart_controller.dart';
import 'package:caferesto/features/shop/controllers/product/checkout_controller.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/order/order_repository.dart';
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

  Widget processOrder(double totalAmount) {}
  
}