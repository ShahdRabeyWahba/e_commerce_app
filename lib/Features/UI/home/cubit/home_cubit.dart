import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:e_commerce_app/domain/use_cases/home/home_use_cases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit(
    this.getCategoriesUseCase,
    this.getProductsUseCase,
  ) : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  final Set<String> wishlistItemIds = {};
  final Set<String> cartItemIds = {};

  void getHomeData() async {
    emit(HomeLoadingState());
    try {
      final categories = await getCategoriesUseCase();
      final products = await getProductsUseCase();
      emit(HomeSuccessState(categories: categories, products: products, wishlistItemIds: Set.from(wishlistItemIds), cartItemIds: Set.from(cartItemIds)));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
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
        wishlistItemIds: Set.from(wishlistItemIds),
        cartItemIds: Set.from(cartItemIds),
      ));
    }
  }

  void toggleCart(String productId) {
    if (cartItemIds.contains(productId)) {
      cartItemIds.remove(productId);
    } else {
      cartItemIds.add(productId);
    }
    
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      emit(HomeSuccessState(
        categories: currentState.categories,
        products: currentState.products,
        wishlistItemIds: Set.from(wishlistItemIds),
        cartItemIds: Set.from(cartItemIds),
      ));
    }
  }
}
