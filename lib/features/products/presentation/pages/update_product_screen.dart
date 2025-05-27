import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/features/products/domain/entities/product_entity.dart';
import 'package:my_task_products/features/products/presentation/cubit/update_product/update_product_cubit.dart';
import 'package:my_task_products/shared/extentions/navigations.dart';
import 'package:my_task_products/shared/widgets/primary_button.dart';
import 'package:my_task_products/shared/widgets/snackbar.dart';
import 'package:my_task_products/shared/widgets/textformfield.dart';
import 'package:my_task_products/shared/widgets/titleAppBar.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() {
    final cubit = context.read<UpdateProductCubit>();
    cubit.title = TextEditingController(text: widget.productEntity.title);
    cubit.description = TextEditingController(
      text: widget.productEntity.description,
    );
    cubit.price = TextEditingController(
      text: widget.productEntity.price.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TitleAppBar(title: "update")),
      body: BlocConsumer<UpdateProductCubit, UpdateProductState>(
        listener: (context, state) {
          if (state is UpdateProductSuccess) {
            showSnackBar("success update ${state.productModel.id}");
            context.pop();
          } else if (state is UpdateProductError) {
            showSnackBar("success created ${state.message}");
          }
        },
        builder: (context, state) {
          final cubit = context.read<UpdateProductCubit>();
          if (state is UpdateProductLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              children: [
                CustomTextFormField(obscureText: true, controller: cubit.title),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  obscureText: true,
                  controller: cubit.description,
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  obscureText: true,
                  controller: cubit.price,
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                SizedBox(height: 10.h),
                PrimaryButton(
                  title: "update",
                  onPressed: () async {
                    await cubit.updateProduct(id: widget.productEntity.id!);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
