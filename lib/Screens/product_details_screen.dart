import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 2; // 40
  int _quantity = 1;

  final List<Color> _colors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.pink,
  ];

  final List<int> _sizes = [38, 39, 40, 41, 42];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.mainColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context).product_details, style: AppStyles.blueMedium18),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.mainColor),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.mainColor),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.cartRoute),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            Stack(
              children: [
                Container(
                  height: 300.h,
                  width: double.infinity,
                  margin: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.network(
                      widget.product.imageCover ?? "",
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.mainColor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image_outlined,
                        color: Colors.grey,
                        size: 60,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30.h,
                  right: 30.w,
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      bool isFavorite = false;
                      if (state is HomeSuccessState) {
                        isFavorite = state.wishlistItemIds.contains(widget.product.id);
                      }
                      return GestureDetector(
                        onTap: () {
                          if (widget.product.id != null) {
                            HomeCubit.get(context).toggleFavorite(widget.product.id!);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: AppColors.mainColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Carousel dots
                Positioned(
                  bottom: 30.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        widget.product.images?.length ?? 1,
                        (index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              width: 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: index == 0 ? AppColors.mainColor : Colors.white60,
                                shape: BoxShape.circle,
                              ),
                            )),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.title ?? "",
                          style: AppStyles.blueMedium18.copyWith(fontSize: 18.sp, color: AppColors.textColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text('EGP ${widget.product.price}',
                          style: AppStyles.blueMedium18.copyWith(fontSize: 18.sp, color: AppColors.textColor)),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: AppColors.mainColor.withValues(alpha: 0.3)),
                        ),
                        child: Text('${widget.product.ratingsQuantity ?? 0} ${AppLocalizations.of(context).sold}',
                            style: AppStyles.blackReg14.copyWith(fontSize: 12.sp)),
                      ),
                      SizedBox(width: 16.w),
                      Icon(Icons.star, color: Colors.amber, size: 20.sp),
                      Text(' ${widget.product.ratingsAverage} (${widget.product.ratingsQuantity})',
                          style: AppStyles.blackReg14.copyWith(fontSize: 12.sp)),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_quantity > 1) {
                                  setState(() {
                                    _quantity--;
                                  });
                                }
                              },
                              child: Icon(Icons.remove_circle_outline, color: Colors.white, size: 20.sp),
                            ),
                            SizedBox(width: 16.w),
                            Text('$_quantity', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                            SizedBox(width: 16.w),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _quantity++;
                                });
                              },
                              child: Icon(Icons.add_circle_outline, color: Colors.white, size: 20.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(AppLocalizations.of(context).description,
                      style: AppStyles.blueMedium18.copyWith(fontSize: 18.sp, color: AppColors.textColor)),
                  SizedBox(height: 8.h),
                  Text(
                    widget.product.description ?? "",
                    style: AppStyles.blackReg14.copyWith(color: AppColors.textColor.withValues(alpha: 0.6), height: 1.5),
                  ),
                  SizedBox(height: 16.h),
                  Text(AppLocalizations.of(context).size, style: AppStyles.blueMedium18.copyWith(fontSize: 18.sp, color: AppColors.textColor)),
                  SizedBox(height: 8.h),
                  Row(
                    children: _sizes.asMap().entries.map((entry) {
                      int idx = entry.key;
                      int val = entry.value;
                      bool isSelected = _selectedSizeIndex == idx;
                      return Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: InkWell(
                          onTap: () => setState(() => _selectedSizeIndex = idx),
                          child: Container(
                            width: 35.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.mainColor : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '$val',
                              style: TextStyle(
                                color: isSelected ? Colors.white : AppColors.textColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.h),
                  Text(AppLocalizations.of(context).color, style: AppStyles.blueMedium18.copyWith(fontSize: 18.sp, color: AppColors.textColor)),
                  SizedBox(height: 8.h),
                  Row(
                    children: _colors.asMap().entries.map((entry) {
                      int idx = entry.key;
                      Color color = entry.value;
                      bool isSelected = _selectedColorIndex == idx;
                      return Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: InkWell(
                          onTap: () => setState(() => _selectedColorIndex = idx),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 38.w,
                            height: 38.h,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: isSelected 
                                ? Border.all(color: AppColors.mainColor, width: 3.w)
                                : Border.all(color: Colors.transparent, width: 3.w),
                              boxShadow: isSelected ? [
                                BoxShadow(
                                  color: AppColors.mainColor.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                )
                              ] : null,
                            ),
                            child: isSelected 
                              ? Icon(Icons.check, color: color == Colors.black ? Colors.white : Colors.white, size: 20.sp) 
                              : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context).total_price, style: AppStyles.blackReg14.copyWith(color: AppColors.textColor.withValues(alpha: 0.6))),
                          Text('EGP ${(widget.product.price ?? 0) * _quantity}', style: AppStyles.blueSemi20.copyWith(fontSize: 18.sp, color: AppColors.textColor)),
                        ],
                      ),
                      SizedBox(width: 32.w),
                      Expanded(
                        child: BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            bool isInCart = false;
                            if (state is HomeSuccessState) {
                              String cartKey = "${widget.product.id}_${_selectedColorIndex}_$_selectedSizeIndex";
                              isInCart = state.cartItemQuantities.containsKey(cartKey);
                            }
                            return ElevatedButton.icon(
                              onPressed: () {
                                if (widget.product.id != null) {
                                  HomeCubit.get(context).toggleCart(
                                    widget.product.id!,
                                    colorIndex: _selectedColorIndex,
                                    sizeIndex: _selectedSizeIndex,
                                    quantity: _quantity,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(isInCart ? 'Removed from Cart' : 'Added to Cart Successfully'),
                                      duration: const Duration(seconds: 1),
                                      backgroundColor: AppColors.mainColor,
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                isInCart ? Icons.check_circle : Icons.add_shopping_cart,
                                color: Colors.white,
                              ),
                              label: Text(
                                isInCart ? AppLocalizations.of(context).remove_from_cart : AppLocalizations.of(context).add_to_cart,
                                style: AppStyles.whiteMedium18.copyWith(fontSize: 16.sp),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mainColor,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
