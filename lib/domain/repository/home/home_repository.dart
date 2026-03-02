import 'package:e_commerce_app/domain/entities/response/category/category.dart';
import 'package:e_commerce_app/domain/entities/response/category/subcategory.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';

abstract class HomeRepository {
  Future<List<Category>> getCategories();
  Future<List<Subcategory>> getSubcategories(String categoryId);
  Future<List<Product>> getProducts();
}
