import 'package:e_commerce_app/data/data_sources/remote/home/home_remote_data_source.dart';
import 'package:e_commerce_app/domain/entities/response/category/category.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';
import 'package:e_commerce_app/domain/repository/home/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Category>> getCategories() {
    return remoteDataSource.getCategories();
  }

  @override
  Future<List<Product>> getProducts() {
    return remoteDataSource.getProducts();
  }
}
