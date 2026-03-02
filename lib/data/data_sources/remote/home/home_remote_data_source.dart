import 'package:e_commerce_app/api/api_manager.dart';
import 'package:e_commerce_app/domain/entities/response/category/category.dart';
import 'package:e_commerce_app/domain/entities/response/category/subcategory.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';

import 'package:injectable/injectable.dart';

abstract class HomeRemoteDataSource {
  Future<List<Category>> getCategories();
  Future<List<Subcategory>> getSubcategories(String categoryId);
  Future<List<Product>> getProducts();
}

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiManager apiManager;

  HomeRemoteDataSourceImpl(this.apiManager);

  @override
  Future<List<Category>> getCategories() async {
    final response = await apiManager.getCategories();
    return response.data?.map((e) => e.toEntity()).toList() ?? [];
  }
  
  @override
  Future<List<Subcategory>> getSubcategories(String categoryId) async {
    final response = await apiManager.getSubcategories(categoryId);
    return response.data?.map((e) => e.toEntity()).toList() ?? [];
  }

  @override
  Future<List<Product>> getProducts() async {
    final response = await apiManager.getProducts();
    return response.data?.map((e) => e.toEntity()).toList() ?? [];
  }
}
