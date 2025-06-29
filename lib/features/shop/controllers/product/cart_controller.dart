import 'package:caferesto/features/shop/controllers/product/variation_controller.dart'
    show VariationController;
import 'package:caferesto/features/shop/models/cart_item_model.dart';
import 'package:caferesto/utils/local_storage/storage_utility.dart';
import 'package:caferesto/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/enums.dart';
import '../../models/product_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt cartItemsCount = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = Get.put(VariationController());

  CartController() {
    loadCartItems();
  }

  // Add items in the cart
  void addToCart(ProductModel product) {
    // Quantity check
    if (productQuantityInCart.value < 1) {
      TLoaders.customToast(message: 'Veuillez choisir une quantité');
      return;
    }

    // Variation Selected?
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      TLoaders.customToast(message: 'Veuillez choisir une variante');
      return;
    }

    // Out of Stock status
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        TLoaders.customToast(message: 'Produit hors stock');
        return;
      }
    } else {
      if (product.stock < 1) {
        TLoaders.customToast(message: 'Produit hors stock');
        return;
      }
    }

    final selectedCartItem =
        productToCartItem(product, productQuantityInCart.value);

    // Check if the item is already in the cart
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);

    // If the item is already in the cart, update its quantity
    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();

    TLoaders.customToast(message: 'Produit ajouté au panier');
  }

  /// Convert a ProductModel to a CartItemModel
  CartItemModel productToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;
    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      image: isVariation ? variation.image : product.thumbnail,
      quantity: quantity,
      variationId: variationController.selectedVariation.value.id,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  void updateCart() {
    updateCartTotals(); // cartItemsCount totalCartPrice
    saveCartItems();
    cartItems.refresh();
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        // Show dialog before completely removing
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Confirmation',
      middleText: 'Voulez-vous vraiment supprimer ce produit du panier?',
      textConfirm: 'Oui',
      textCancel: 'Non',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        TLoaders.customToast(message: 'Produit supprimé du panier');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedcartItemsCount = 0;
    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedcartItemsCount += item.quantity;
    }
    totalCartPrice.value = calculatedTotalPrice;
    cartItemsCount.value = calculatedcartItemsCount;
  }

  void saveCartItems() async {
    // Save cart items in SharedPreferences
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    TLocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  void loadCartItems() async {
    // Load cart items from SharedPreferences
    final cartItemStrings =
        TLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty());
    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  /// --initialize already added Item(s Count in the cart)
  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }
}
