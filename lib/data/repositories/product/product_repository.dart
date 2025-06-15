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

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
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

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
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
          title: 'Délice',
          stock: 10,
          price: 1.5,
          isFeatured: true,
          thumbnail: TImages.productImage1,
          description: 'Freshly roasted organic coffee beans.',
          salePrice: 1,
          productType: 'Simple',
          sku: 'COF-001',
          categoryId: 'cat1',
          images: [
            TImages.productImage10,
            TImages.productImage11,
          ],
          brand: BrandModel(
            id: 'b1',
            name: 'CoffeeLand',
            image: TImages.productImage10,
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
              price: 1.5,
              salePrice: 0,
              stock: 20,
              attributeValues: {'Weight': '250g'},
            ),
            ProductVariationModel(
              id: 'pv2',
              sku: 'COF-500G',
              image: TImages.productImage2,
              price: 1.5,
              salePrice: 0,
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
          productType: 'ProductType.variable',
          sku: 'COF-001',
          categoryId: 'cat1',
          images: [
            TImages.productImage10,
            TImages.productImage11,
          ],
          brand: BrandModel(
            id: 'b2',
            name: 'Hsouna',
            image: TImages.productImage3,
            isFeatured: true,
            productsCount: 10,
          ),
          productAttributes: [
            ProductAttributeModel(
              name: 'Pattes',
              values: ['simple', 'double'],
            ),
            ProductAttributeModel(
              name: 'Ingrédients',
              values: [
                'Thon',
                'Thon-Omlette',
                'Thon-Fromage',
                'Thon-Fromage-Omlette',
                'Spécial',
                'Chawarma',
                'Cordon Bleu'
              ],
            ),
          ],
          productVariations: [
            ProductVariationModel(
              id: 'pv1',
              sku: 'COF-250G',
              image: TImages.productImage1,
              price: 5.5,
              salePrice: 5.0,
              stock: 20,
              attributeValues: {'Ingrédients': 'Thon', 'Pattes': 'simple'},
            ),
            ProductVariationModel(
              id: 'pv2',
              sku: 'COF-500G',
              image: TImages.productImage2,
              price: 6.0,
              salePrice: 5.8,
              stock: 30,
              attributeValues: {
                'Ingrédients': 'Thon-Omlette',
                'Pattes': 'double'
              },
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
