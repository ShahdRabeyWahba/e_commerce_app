import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/widgets/cart_item.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Map<String, int> _quantities = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List cartProducts = [];
        if (state is HomeSuccessState && state.products != null) {
          cartProducts = state.products!.where((p) => state.cartItemIds.contains(p.id)).toList();
        }

        num totalPrice = 0;
        for (var product in cartProducts) {
          int qty = _quantities[product.id] ?? 1;
          totalPrice += (product.price ?? 0) * qty;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Cart', style: AppStyles.medium18black),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.mainColor),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: cartProducts.isEmpty
              ? Center(
                  child: Text(
                    "Your Cart is Empty",
                    style: AppStyles.blueMedium18,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: cartProducts.length,
                          separatorBuilder: (context, index) => SizedBox(height: 24.h),
                          itemBuilder: (context, index) {
                            final product = cartProducts[index];
                            return CartItem(
                              product: product,
                              quantity: _quantities[product.id] ?? 1,
                              onQuantityChanged: (newQty) {
                                setState(() {
                                  _quantities[product.id!] = newQty;
                                });
                              },
                              onDelete: () {
                                if (product.id != null) {
                                  HomeCubit.get(context).toggleCart(product.id!);
                                }
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
                              Text('Total Price', style: AppStyles.blackReg14.copyWith(color: AppColors.textColor.withOpacity(0.6))),
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
                                Text('Check out', style: AppStyles.whiteMedium18.copyWith(fontSize: 16.sp)),
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
