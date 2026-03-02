import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/widgets/cart_item.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(color: AppColors.mainColor)),
          );
        }

        if (state is HomeErrorState) {
          return Scaffold(
            appBar: AppBar(title: Text(AppLocalizations.of(context).cart)),
            body: Center(child: Text(state.errorMessage ?? "Error")),
          );
        }

        List<Map<String, dynamic>> cartItems = [];
        if (state is HomeSuccessState && state.allProducts != null) {
          state.cartItemQuantities.forEach((cartKey, quantity) {
            final parts = cartKey.split('_');
            final productId = parts[0];
            int colorIdx = 0;
            int sizeIdx = 0;
            
            if (parts.length >= 3) {
              colorIdx = int.tryParse(parts[1]) ?? 0;
              sizeIdx = int.tryParse(parts[2]) ?? 0;
            }
            
            final product = state.allProducts!.firstWhere(
              (p) => p.id == productId,
              orElse: () => Product(id: productId, title: "Product Not Found"),
            );
            cartItems.add({
              'product': product,
              'colorIndex': colorIdx,
              'sizeIndex': sizeIdx,
              'cartKey': cartKey,
              'quantity': quantity,
            });
          });
        }

        num totalPrice = 0;
        for (var item in cartItems) {
          final product = item['product'] as Product;
          int qty = item['quantity'] as int;
          totalPrice += (product.price ?? 0) * qty;
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            toolbarHeight: 55.h,
            title: Image.asset(
              AppAssets.logoRoute,
              width: 120.w,
              color: AppColors.mainColor,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.mainColor),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: cartItems.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context).empty_cart,
                    style: AppStyles.blueMedium18,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: cartItems.length,
                          separatorBuilder: (context, index) => SizedBox(height: 24.h),
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            final product = item['product'] as Product;
                            final cartKey = item['cartKey'] as String;
                            
                            return CartItem(
                              product: product,
                              quantity: item['quantity'],
                              colorIndex: item['colorIndex'],
                              sizeIndex: item['sizeIndex'],
                              onQuantityChanged: (newQty) {
                                HomeCubit.get(context).updateCartQuantity(cartKey, newQty);
                              },
                              onDelete: () {
                                final parts = cartKey.split('_');
                                int cIdx = 0;
                                int sIdx = 0;
                                if (parts.length >= 3) {
                                  cIdx = int.tryParse(parts[1]) ?? 0;
                                  sIdx = int.tryParse(parts[2]) ?? 0;
                                }
                                HomeCubit.get(context).toggleCart(
                                  parts[0],
                                  colorIndex: cIdx,
                                  sizeIndex: sIdx,
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(AppLocalizations.of(context).total_price, style: AppStyles.blackReg14.copyWith(color: AppColors.textColor.withValues(alpha: 0.6))),
                              Text('EGP $totalPrice', style: AppStyles.blueSemi20.copyWith(fontSize: 18.sp, color: AppColors.textColor)),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                            ),
                            child: Row(
                              children: [
                                Text(AppLocalizations.of(context).checkout, style: AppStyles.whiteMedium18.copyWith(fontSize: 16.sp)),
                                SizedBox(width: 24.w),
                                const Icon(Icons.arrow_forward, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
