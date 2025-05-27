import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';
import 'package:my_task_products/features/products/domain/entities/product_entity.dart';
import 'package:my_task_products/shared/classes/text_style.dart';
import 'package:my_task_products/shared/resources/color_resources.dart';
import 'package:my_task_products/shared/resources/images_resources.dart';

class DisplayProductsWidget extends StatelessWidget {
  const DisplayProductsWidget({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(2, 2),
            blurRadius: 7,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: FancyShimmerImage(
                // boxFit: BoxFit.contain,
                errorWidget: Image.asset(
                  ImagesResources.errorImage,
                  height: 50.h,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                imageUrl: product.images.first,
                height: 50.h,
                width: 80,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTextStyle.textStyle(
                    appFontWeight: FontWeight.w600,
                    appFontSize: 13.sp,
                    color: ColorResources.blackColor,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(
                      "(${countComments(product.reviews)})",
                      style: AppTextStyle.textStyle(
                        appFontWeight: FontWeight.w600,
                        appFontSize: 13.sp,
                        color: ColorResources.blackColor,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      product.rating!.toString(),
                      style: AppTextStyle.textStyle(
                        appFontWeight: FontWeight.w600,
                        appFontSize: 13.sp,
                        color: ColorResources.blackColor,
                      ),
                    ),
                    Icon(Icons.star, color: Colors.yellow, size: 19),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: Colors.grey,
                      size: 18,
                    ),
                    SizedBox(width: 5.w),
                    Text("${getTime(product.reviews)}.د"),
                    SizedBox(width: 10.w),
                    Text("${product.price} ج.م"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

int countComments(List<Review> reviews) {
  int sum = 0;
  for (var i = 0; i < reviews.length; i++) {
    final result = reviews[i].comment!.length;
    sum += result;
  }
  return sum;
}

int getTime(List<Review> reviews) {
  int time = 0;
  for (var i = 0; i < reviews.length; i++) {
    final result = reviews[i].date!.minute;
    time = result;
  }
  return time;
}
