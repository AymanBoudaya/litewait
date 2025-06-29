import 'dart:convert';

import 'package:caferesto/data/repositories/product/product_repository.dart';
import 'package:caferesto/features/shop/models/product_model.dart';
import 'package:caferesto/utils/local_storage/storage_utility.dart';
import 'package:caferesto/utils/popups/loaders.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  /// Variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  void initFavorites() {
    final json = TLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      TLoaders.customToast(message: 'Produit ajouté aux favoris');
    } else {
      TLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      TLoaders.customToast(message: 'Produit retiré des favoris');
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    TLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance.getFavoriteProducts(favorites.keys.toList());
  }
}
