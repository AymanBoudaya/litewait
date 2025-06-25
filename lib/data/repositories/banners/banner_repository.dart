import 'package:caferesto/utils/exceptions/firebase_exceptions.dart';
import 'package:caferesto/utils/exceptions/format_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../../features/shop/models/banner_model.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;


  // Get all order related to current user
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Quelque chose s\'est mal passée lors de la récupération des bannières.';
    }
  }
}
