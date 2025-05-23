import 'package:caferesto/features/shop/models/category_model.dart';
import 'package:caferesto/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../data/repositories/categories/category_repository.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  /// Variables
  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  /// Get all categories
  Future<void> fetchCategories() async {
    try {
      // Show loader
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API, etc.)
      final categories = await _categoryRepository.getAllCategories();
      print('Données récupérées:' 
          ' ${categories.length} categories');
      for (var c in categories) {
        print(
            ' - ${c.name}, image: ${c.image}, featured: ${c.isFeatured}, parentId: ${c.parentId}');
      }

      // Update the categories list
      allCategories.assignAll(categories);

      // Filter featured categories
      featuredCategories.assignAll(categories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
