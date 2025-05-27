import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/app_injections.dart' as di;
import 'package:my_task_products/core/functions/convert_to_number.dart';
import 'package:my_task_products/features/products/presentation/cubit/add_product/add_product_cubit.dart';
import 'package:my_task_products/shared/extentions/navigations.dart';
import 'package:my_task_products/shared/widgets/primary_button.dart';
import 'package:my_task_products/shared/widgets/snackbar.dart';
import 'package:my_task_products/shared/widgets/textformfield.dart';
import 'package:my_task_products/shared/widgets/titleAppBar.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddProductCubit>(
      create: (context) => di.sl<AddProductCubit>(),
      child: Scaffold(
        appBar: AppBar(title: TitleAppBar(title: "add new product")),
        body: BlocConsumer<AddProductCubit, AddProductState>(
          listener: (context, state) {
            if (state is AddProductError) {
              showSnackBar(state.message);
            } else if (state is AddProductSuccess) {
              showSnackBar("add product ${state.productModel.id} success");
              context.pop();
            }
          },
          builder: (context, state) {
            final cubit = context.read<AddProductCubit>();
            if (state is AddProductLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      obscureText: true,
                      hintText: "title",
                      controller: cubit.title,
                    ),
                    SizedBox(height: 10),
                    CustomTextFormField(
                      obscureText: true,
                      hintText: "description",
                      controller: cubit.description,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      hintText: "discountPercentage",
                      controller: cubit.discountPercentage,
                      onChanged: (value) {
                        try {
                          cubit.priceProduct = convertToNumber(value);
                        } catch (e) {
                          showSnackBar("please enter a number");
                          throw Exception(e.toString());
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      obscureText: true,
                      hintText: "shippingInformation",
                      controller: cubit.shippingInformation,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      onChanged: (value) {
                        try {
                          cubit.priceProduct = convertToNumber(value);
                        } catch (e) {
                          showSnackBar("please enter a number");
                          throw Exception(e.toString());
                        }
                      },
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      hintText: "price",
                      controller: cubit.price,
                    ),
                    SizedBox(height: 10.h),
                    PrimaryButton(
                      title: "Add new Product",
                      onPressed: () async {
                        await cubit.addProduct();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
