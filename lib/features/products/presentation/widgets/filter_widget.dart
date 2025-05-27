import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/features/products/presentation/cubit/products/filter_products/filter_products_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/products/options/options_cubit.dart';
import 'package:my_task_products/shared/extentions/navigations.dart';
import 'package:my_task_products/shared/widgets/primary_button.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        height: 240.h,
        width: 80.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                context.read<SharedCubit>().isFiltering(false);
                context.pop();
              },
              child: Text("Display All"),
            ),

            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sort By Title"),
                    BlocBuilder<SharedCubit, SharedState>(
                      builder: (context, state) {
                        final cubit = context.read<SharedCubit>();
                        return Checkbox(
                          value: cubit.isValue,
                          onChanged: (val) {
                            if (val != null) {
                              cubit.isSelectedCheckBox(val);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order"),
                    BlocBuilder<SharedCubit, SharedState>(
                      builder: (context, state) {
                        final cubit = context.read<SharedCubit>();
                        return DropdownButton<String>(
                          value: cubit.order,
                          items:
                              ['asc', 'desc'].map((val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(val.toUpperCase()),
                                );
                              }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              cubit.selectedRole(val);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            BlocBuilder<FilterProductsCubit, FilterProductsState>(
              builder: (context, state) {
                final cubit = context.read<SharedCubit>();
                return PrimaryButton(
                  title: "filter",
                  onPressed: () async {
                    await context
                        .read<FilterProductsCubit>()
                        .filteringProducts(
                          sortBy: cubit.isValue ? cubit.sortBy : '',
                          order: cubit.order,
                        )
                        .then((_) {
                          context.pop();
                          cubit.isFiltering(true);
                        });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
