import 'package:e_commerce_app/Features/UI/home/cubit/home_cubit.dart';
import 'package:e_commerce_app/Features/UI/home/cubit/home_states.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(child: CircularProgressIndicator(color: AppColors.mainColor));
        } else if (state is HomeSuccessState) {
          final categories = state.categories ?? [];
          if (categories.isEmpty) return const Center(child: Text("No Categories Found"));

          return Row(
            children: [
              // Sidebar
              Container(
                width: 137.w,
                color: const Color(0xFFF3F3F3),
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedCategoryIndex == index;
                    return InkWell(
                      onTap: () => setState(() => _selectedCategoryIndex = index),
                      child: Container(
                        height: 82.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.transparent,
                          border: isSelected
                              ? Border(
                                  left: BorderSide(color: AppColors.mainColor, width: 7.w),
                                )
                              : null,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          categories[index].name ?? "",
                          style: AppStyles.blueSemi20.copyWith(
                            fontSize: 14.sp,
                            color: isSelected ? AppColors.mainColor : AppColors.textColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Category Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categories[_selectedCategoryIndex].name ?? "",
                        style: AppStyles.blueSemi20.copyWith(fontSize: 14.sp),
                      ),
                      SizedBox(height: 16.h),
                      // Banner Placeholder
                      Container(
                        height: 100.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: NetworkImage(categories[_selectedCategoryIndex].image ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Subcategories Grid Placeholder (Since we don't have subcategories call yet)
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 12.h,
                          ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 70.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    image: DecorationImage(
                                      image: NetworkImage(categories[_selectedCategoryIndex].image ?? ""),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "Item $index",
                                  style: AppStyles.blackReg14.copyWith(fontSize: 10.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is HomeErrorState) {
          return Center(child: Text(state.errorMessage ?? "Error"));
        }
        return const SizedBox();
      },
    );
  }
}
