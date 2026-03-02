import 'package:e_commerce_app/domain/entities/response/category/category.dart';
import 'package:e_commerce_app/domain/entities/response/category/subcategory.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<Category>? categories;
  final List<Subcategory>? subcategories;
  final List<Product>? products;
  final List<Product>? allProducts;
  final Set<String> wishlistItemIds;
  final Map<String, int> cartItemQuantities;
  final String? searchQuery;
  final String? selectedCategoryId;
  final String? selectedSubcategoryId;

  HomeSuccessState({
    this.categories,
    this.subcategories,
    this.products,
    this.allProducts,
    this.wishlistItemIds = const {},
    this.cartItemQuantities = const {},
    this.searchQuery,
    this.selectedCategoryId,
    this.selectedSubcategoryId,
  });
}

class HomeErrorState extends HomeState {
  final String? errorMessage;

  HomeErrorState({this.errorMessage});
}
