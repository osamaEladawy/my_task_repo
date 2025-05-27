import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/app_injections.dart' as di;
import 'package:my_task_products/core/routes/routes.dart';
import 'package:my_task_products/features/products/presentation/cubit/delete_product/delete_product_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/products/product_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/update_product/update_product_cubit.dart';
import 'package:my_task_products/features/products/presentation/pages/update_product_screen.dart';
import 'package:my_task_products/features/products/presentation/widgets/display_products_widget.dart';
import 'package:my_task_products/shared/extentions/navigations.dart';
import 'package:my_task_products/shared/widgets/snackbar.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
    _fetchInitialData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      _fetchInitialData();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _fetchInitialData() async {
    context.read<ProductCubit>().getProducts();
  }

  void _refreshData() async {
    context.read<ProductCubit>().products.clear();
    context.read<ProductCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<DeleteProductCubit>(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            context.pushNamed(Routes.addProduct);
          },
        ),
        // : null,
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            final cubit = context.read<ProductCubit>();
            final products = cubit.products;
            //final isLoading = cubit.isLoading;
            final hasMore = cubit.hasMoreData;

            if (state is ProductsLoading && products.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductsError && products.isEmpty) {
              return Center(child: Text(state.message));
            }

            return RefreshIndicator(
              onRefresh: () async => _refreshData(),
              child: ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: products.length + (hasMore ? 1 : 0),
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  if (index < products.length) {
                    final product = products[index];
                    return BlocConsumer<DeleteProductCubit, DeleteProductState>(
                      builder: (context, state) {
                        final deleteCubit = context.read<DeleteProductCubit>();
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async {
                            await deleteCubit.deleteProduct(id: product.id!);
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              context.push(
                                BlocProvider(
                                  create: (_) => di.sl<UpdateProductCubit>(),
                                  child: UpdateProductScreen(
                                    productEntity: product,
                                  ),
                                ),
                              );
                              // context.pushNamed(
                              //   Routes.updateProduct,
                              //   arguments: product,
                              // );
                            },
                            child: DisplayProductsWidget(product: product),
                          ),
                        );
                      },
                      listener: (
                        BuildContext context,
                        DeleteProductState state,
                      ) {
                        if (state is DeleteProductSuccess) {
                          showSnackBar(
                            "delete product ${state.productModel.id}",
                          );
                        } else if (state is DeleteProductError) {
                          showSnackBar(state.message);
                        }
                      },
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
