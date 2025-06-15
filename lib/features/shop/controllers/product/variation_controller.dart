import 'package:caferesto/features/shop/controllers/product/images_controller.dart';
import 'package:caferesto/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  /// -- Select Attribute, and variation
  void onAttributeSelected(ProductModel product, attributeName, attribueValue) {
    final selectedAttributes = Map<String, dynamic>.from(
        this.selectedAttributes); // Create a copy of the selected attributes
  selectedAttributes[attributeName] = attribueValue;
  this.selectedAttributes[attributeName] = attribueValue;

    // Check if the selected attributes match any variation attributes
    final selectedVariation = product.productVariations?.firstWhere(
      (variation) => _isSameAttributeValues(
        variation.attributeValues,
        selectedAttributes,
      ),
      orElse: () => ProductVariationModel.empty(),
    );

    // If a matching variation is found, update the selected variation and stock status
    if (selectedVariation!.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    } 
    // Assign the selected variation to the observable
    this.selectedVariation.value = selectedVariation;
    // Update stock status based on the selected variation
    getProductVariationStockStatus();
  }

///   -- Check if selected attributes match any variation attributes
bool _isSameAttributeValues(
  Map<String, dynamic> variationAttributes,
  Map<String, dynamic> selectedAttributes,
    ) {
      /// If selected attributes contains 3 attributes and current variation contains 2 then return
      if (variationAttributes.length != selectedAttributes.length) {
        return false;
      }

      // If any of the attributes is diffrent then return
      for (final key in variationAttributes.keys) {
        if (variationAttributes[key] != selectedAttributes[key]) {
          return false;
        }
      }

      return true;
    }
  /// -- Check Attribute availability / Stock in variation
  Set<String?> getAttributesAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
        final availableVariationAttributeValues = variations.where((variation) =>
            variation.attributeValues[attributeName] != null && variation.attributeValues[attributeName]!.isNotEmpty && variation.stock > 0)
            .map((variation) => variation.attributeValues[attributeName]
            ).toSet();
    return availableVariationAttributeValues;
      }

      String getVariationPrice() {
        return (selectedVariation.value.salePrice > 0 ?
                selectedVariation.value.salePrice :
             selectedVariation.value.price).toString();
      }

  /// -- Check Product Variation Stock status
  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'En Stock' : 'Hors Stock';
  }

  /// -- Reset Selected Attributes when switching products
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
