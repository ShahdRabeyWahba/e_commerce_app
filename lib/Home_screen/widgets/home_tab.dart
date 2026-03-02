import 'dart:async';
import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/widgets/category_brand_item.dart';
import 'package:e_commerce_app/widgets/product_tab_item.dart';
import 'package:e_commerce_app/widgets/product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatefulWidget {
  final VoidCallback onViewAll;
  final Function(String)? onCategoryTap;
  const HomeTab({super.key, required this.onViewAll, this.onCategoryTap});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _bannerImages = [
    AppAssets.advertisement,
    AppAssets.advertisement2,
    AppAssets.advertisement3,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const ProductGridShimmer();
        } else if (state is HomeSuccessState) {
          final local = AppLocalizations.of(context);
          final isSearching = state.searchQuery != null && state.searchQuery!.isNotEmpty;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isSearching) ...[
                  // Banner
                  _buildBanner(context),

                  // Categories Header
                  _buildHeader(local.categories, local.view_all, widget.onViewAll),
                  
                  // Categories Horizontal List (2 Rows)
                  SizedBox(
                    height: 420.h,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: state.categories?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.1,
                        mainAxisSpacing: 16.w,
                        crossAxisSpacing: 16.h,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => widget.onCategoryTap?.call(state.categories![index].id ?? ""),
                          child: CategoryBrandItem(category: state.categories![index]),
                        );
                      },
                    ),
                  ),

                  // Home Appliance Header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Text(local.home_appliance, style: AppStyles.blueMedium18),
                  ),
                ] else
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Text('${AppLocalizations.of(context).results_for} "${state.searchQuery}"', style: AppStyles.blueSemi20),
                  ),

                // Products Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.55,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                  ),
                  itemCount: state.products?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ProductTabItem(product: state.products![index]);
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        } else if (state is HomeErrorState) {
          return Center(child: Text(state.errorMessage ?? "Error"));
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      height: 200.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _bannerImages.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  _bannerImages[index],
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.error),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 12.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _bannerImages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: _currentPage == index ? 24.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? AppColors.mainColor : Colors.white70,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.white, width: 0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, String actionText, [VoidCallback? onTap]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyles.blueMedium18),
          InkWell(
            onTap: onTap,
            child: Text(actionText, style: AppStyles.blackReg14.copyWith(fontSize: 12.sp)),
          ),
        ],
      ),
    );
  }
}
