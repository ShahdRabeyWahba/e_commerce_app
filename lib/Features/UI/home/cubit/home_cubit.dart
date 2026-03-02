import 'package:flutter/material.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';
import 'package:e_commerce_app/domain/entities/response/category/subcategory.dart';
import 'package:e_commerce_app/domain/use_cases/home/home_use_cases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetSubcategoriesUseCase getSubcategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit(
    this.getCategoriesUseCase,
    this.getSubcategoriesUseCase,
    this.getProductsUseCase,
  ) : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  final Set<String> wishlistItemIds = {};
  // Stores unique cart items as: productId_colorIndex_sizeIndex -> quantity
  final Map<String, int> cartItemQuantities = {};

  List<Product> _allProducts = [];

  void getHomeData() async {
    emit(HomeLoadingState());
    try {
      final categories = await getCategoriesUseCase();
      final products = await getProductsUseCase();
      _allProducts = products;
      emit(HomeSuccessState(
          categories: categories,
          subcategories: [], // Initialize empty
          products: products,
          allProducts: _allProducts,
          wishlistItemIds: Set.from(wishlistItemIds),
          cartItemQuantities: Map.from(cartItemQuantities),
          searchQuery: ""));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  void searchProducts(String query) {
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      if (query.isEmpty) {
        emit(HomeSuccessState(
            categories: currentState.categories,
            products: _allProducts,
            allProducts: _allProducts,
            wishlistItemIds: Set.from(wishlistItemIds),
            cartItemQuantities: Map.from(cartItemQuantities),
            searchQuery: ""));
      } else {
        final filtered = _allProducts
            .where((p) => p.title?.toLowerCase().contains(query.toLowerCase()) ?? false)
            .toList();
        emit(HomeSuccessState(
            categories: currentState.categories,
            products: filtered,
            allProducts: _allProducts,
            wishlistItemIds: Set.from(wishlistItemIds),
            cartItemQuantities: Map.from(cartItemQuantities),
            searchQuery: query));
      }
    }
  }

  void filterByCategory(String? categoryId) async {
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      
      // Fetch subcategories
      List<Subcategory>? subCats;
      if (categoryId != null) {
        try {
          subCats = await getSubcategoriesUseCase(categoryId);
        } catch (e) {
          subCats = [];
        }
      }

      List<Product> filtered;
      if (categoryId == null) {
        filtered = _allProducts;
      } else {
        filtered = _allProducts.where((p) => p.category?.id == categoryId).toList();
      }

      emit(HomeSuccessState(
        categories: currentState.categories,
        subcategories: subCats,
        products: filtered,
        allProducts: _allProducts,
        wishlistItemIds: Set.from(wishlistItemIds),
        cartItemQuantities: Map.from(cartItemQuantities),
        searchQuery: currentState.searchQuery,
        selectedCategoryId: categoryId,
        selectedSubcategoryId: null, // Reset subcategory when category changes
      ));
    }
  }

  void filterBySubcategory(String? subcategoryId) {
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      List<Product> filtered;
      if (subcategoryId == null) {
        filtered = _allProducts.where((p) => p.category?.id == currentState.selectedCategoryId).toList();
      } else {
        // Here we'd filter by subcategory if products had subcategory ID.
        // For now we'll just show all from category or filter by name match if possible.
        // Since Subcategory is likely what the user wants to see in the grid,
        // we'll emit the subcategory ID so the UI can navigate.
        filtered = _allProducts.where((p) => p.category?.id == currentState.selectedCategoryId).toList();
      }
      emit(HomeSuccessState(
        categories: currentState.categories,
        subcategories: currentState.subcategories,
        products: filtered,
        allProducts: _allProducts,
        wishlistItemIds: Set.from(wishlistItemIds),
        cartItemQuantities: Map.from(cartItemQuantities),
        searchQuery: currentState.searchQuery,
        selectedCategoryId: currentState.selectedCategoryId,
        selectedSubcategoryId: subcategoryId,
      ));
    }
  }

  void toggleFavorite(String productId) {
    if (wishlistItemIds.contains(productId)) {
      wishlistItemIds.remove(productId);
    } else {
      wishlistItemIds.add(productId);
    }
    
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      emit(HomeSuccessState(
        categories: currentState.categories,
        products: currentState.products,
        allProducts: _allProducts,
        wishlistItemIds: Set.from(wishlistItemIds),
        cartItemQuantities: Map.from(cartItemQuantities),
        searchQuery: currentState.searchQuery,
        selectedCategoryId: currentState.selectedCategoryId,
      ));
    }
  }

  void toggleCart(String productId, {int? colorIndex, int? sizeIndex, int quantity = 1}) {
    String cartKey = "${productId}_${colorIndex ?? 0}_${sizeIndex ?? 0}";
    
    if (cartItemQuantities.containsKey(cartKey)) {
      cartItemQuantities.remove(cartKey);
    } else {
      cartItemQuantities[cartKey] = quantity;
    }
    
    _emitHomeSuccess();
  }

  void updateCartQuantity(String cartKey, int quantity) {
    if (cartItemQuantities.containsKey(cartKey)) {
      if (quantity > 0) {
        cartItemQuantities[cartKey] = quantity;
      } else {
        cartItemQuantities.remove(cartKey);
      }
      _emitHomeSuccess();
    }
  }

  void _emitHomeSuccess() {
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      emit(HomeSuccessState(
        categories: currentState.categories,
        subcategories: currentState.subcategories,
        products: currentState.products,
        allProducts: _allProducts,
        wishlistItemIds: Set.from(wishlistItemIds),
        cartItemQuantities: Map.from(cartItemQuantities),
        searchQuery: currentState.searchQuery,
        selectedCategoryId: currentState.selectedCategoryId,
        selectedSubcategoryId: currentState.selectedSubcategoryId,
      ));
    }
  }
}
