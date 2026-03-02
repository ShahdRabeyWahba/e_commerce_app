import 'package:e_commerce_app/domain/entities/response/category/category.dart';
import 'package:e_commerce_app/domain/entities/response/category/subcategory.dart';
import 'package:e_commerce_app/domain/repository/home/home_repository.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetCategoriesUseCase {
  final HomeRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<Category>> call() {
    return repository.getCategories();
  }
}

@Injectable()
class GetSubcategoriesUseCase {
  final HomeRepository repository;

  GetSubcategoriesUseCase(this.repository);

  Future<List<Subcategory>> call(String categoryId) {
    return repository.getSubcategories(categoryId);
  }
}

@Injectable()
class GetProductsUseCase {
  final HomeRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<Product>> call() {
    return repository.getProducts();
  }
}
