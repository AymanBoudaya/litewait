import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../features/shop/models/product_attribute_model.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../features/shop/models/product_variation_model.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// Firestore instance for database interactions
  final _db = FirebaseFirestore.instance;

  /// Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again';
    }
  }

  /// Upload dummy data to the Cloud Firebase
  Future<void> uploadDummyData() async {
    try {
      final List<ProductModel> dummyProducts = [
        ProductModel(
          id: '001',
          title: 'Organic Coffee Beans',
          stock: 50,
          price: 25.5,
          isFeatured: true,
          thumbnail: TImages.productImage1,
          description: 'Freshly roasted organic coffee beans.',
          salePrice: 19.9,
          productType: 'Simple',
          sku: 'COF-001',
          categoryId: 'cat1',
          images: [
            'https://example.com/coffee_1.png',
            'https://example.com/coffee_2.png',
          ],
          brand: BrandModel(
            id: 'b1',
            name: 'CoffeeLand',
            image: 'https://example.com/brand_coffeeland.png',
            isFeatured: true,
            productsCount: 10,
          ),
          productAttributes: [
            ProductAttributeModel(
              name: 'Weight',
              values: ['250g', '500g', '1kg'],
            ),
          ],
          productVariations: [
            ProductVariationModel(
              id: 'pv1',
              sku: 'COF-250G',
              image: TImages.productImage1,
              price: 12.5,
              salePrice: 10.0,
              stock: 20,
              attributeValues: {'Weight': '250g'},
            ),
            ProductVariationModel(
              id: 'pv2',
              sku: 'COF-500G',
              image: 'https://example.com/coffee_500g.png',
              price: 20.0,
              salePrice: 16.0,
              stock: 30,
              attributeValues: {'Weight': '500g'},
            ),
          ],
        ),
        ProductModel(
          id: '002',
          title: 'Mlewi',
          stock: 50,
          price: 5.5,
          isFeatured: true,
          thumbnail: TImages.productImage5,
          description: 'Mlewi de différentes variétés et gouts.',
          salePrice: 5.9,
          productType: 'Simple',
          sku: 'COF-001',
          categoryId: 'cat1',
          images: [
            'https://example.com/coffee_1.png',
            'https://example.com/coffee_2.png',
          ],
          brand: BrandModel(
            id: 'b2',
            name: 'Hsouna',
            image: 'https://example.com/brand_coffeeland.png',
            isFeatured: true,
            productsCount: 10,
          ),
          productAttributes: [
            ProductAttributeModel(
              name: 'Pattes',
              values: ['simple', 'double'],
            ),
          ],
          productVariations: [
            ProductVariationModel(
              id: 'pv1',
              sku: 'COF-250G',
              image: TImages.productImage1,
              price: 12.5,
              salePrice: 10.0,
              stock: 20,
              attributeValues: {'Pattes': 'simple'},
            ),
            ProductVariationModel(
              id: 'pv2',
              sku: 'COF-500G',
              image: 'https://example.com/coffee_500g.png',
              price: 20.0,
              salePrice: 16.0,
              stock: 30,
              attributeValues: {'Pattes': 'double'},
            ),
          ],
        ),

        // You can define more dummy products here
      ];

      // Upload each product to Firestore
      for (var product in dummyProducts) {
        await _db.collection('Products').doc(product.id).set(product.toJson());
      }                                        

      print('Dummy products uploaded successfully.');
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong! Please try again.';
    }
  }
}
