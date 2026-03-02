import 'package:e_commerce_app/domain/entities/response/category/category.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<Category>? categories;
  final List<Product>? products;
  final Set<String> wishlistItemIds;
  final Set<String> cartItemIds;

  HomeSuccessState({
    this.categories,
    this.products,
    this.wishlistItemIds = const {},
    this.cartItemIds = const {},
  });
}

class HomeErrorState extends HomeState {
  final String? errorMessage;

  HomeErrorState({this.errorMessage});
}
