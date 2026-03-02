import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSlider extends StatelessWidget {
  final List<String> items;

  const ProductSlider({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: PageView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.r),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(
                items[index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}
