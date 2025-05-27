import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/core/routes/routes.dart';
import 'package:my_task_products/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/products/filter_products/filter_products_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/products/options/options_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/products/product_cubit.dart';
import 'package:my_task_products/features/products/presentation/widgets/display_products_widget.dart';
import 'package:my_task_products/features/products/presentation/widgets/filter_widget.dart';
import 'package:my_task_products/shared/extentions/navigations.dart';
import 'package:my_task_products/shared/resources/color_resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController scrollController;
  bool isFilter = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
    _fetchInitialData();
    _filterProducts();
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
    await context.read<ProductCubit>().getProducts();
  }

  void _filterProducts() async {
    await context.read<FilterProductsCubit>().filteringProducts(
      sortBy: context.read<SharedCubit>().sortBy,
      order: context.read<SharedCubit>().order,
    );
  }

  void _refreshData() async {
    context.read<ProductCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedCubit, SharedState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: SizedBox(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            backgroundColor: ColorResources.primaryColor,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LogOutSuccess) {
                    context.pushNamedAndRemoveUntil(Routes.splash);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return FilterWidget();
                          },
                        );
                      },
                      icon: Icon(
                        Icons.filter_list_outlined,
                        color: ColorResources.whiteColor,
                      ),
                    ),

                    IconButton(
                      onPressed: () async {
                        context.read<AuthCubit>().logOut();
                      },
                      icon: Icon(
                        Icons.logout_rounded,
                        color: ColorResources.whiteColor,
                      ),
                    ),
                  ],
                ),
              ), //_buildFilters(),
            ),
          ),
          body:
              context.read<SharedCubit>().isFilter
                  ? BlocBuilder<FilterProductsCubit, FilterProductsState>(
                    builder: (context, state) {
                      // final cubit = context.read<FilterProductsCubit>();
                      if (state is FilterProductsLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is FilterProductsError) {
                        return Center(child: Text(state.message));
                      } else if (state is FilterProductsLoaded) {
                        final products = state.products;
                        return RefreshIndicator(
                          onRefresh: () async => _refreshData(),
                          child: ListView.separated(
                            shrinkWrap: true,
                            controller: scrollController,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                            itemCount: products.length,
                            separatorBuilder:
                                (context, index) => SizedBox(height: 10.h),
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return DisplayProductsWidget(product: product);
                            },
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  )
                  : BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      final cubit = context.read<ProductCubit>();
                      final products = cubit.products;
                      //final isLoading = cubit.isLoading;
                      final hasMore = cubit.hasMoreData;

                      if (state is ProductsLoading && products.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductsError && products.isEmpty) {
                        return Center(child: Text(state.message));
                      } else if (state is ProductsLoaded ||
                          products.isNotEmpty) {
                        return RefreshIndicator(
                          onRefresh: () async => _refreshData(),
                          child: ListView.separated(
                            shrinkWrap: true,
                            controller: scrollController,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                            itemCount: products.length + (hasMore ? 1 : 0),
                            separatorBuilder:
                                (context, index) => SizedBox(height: 10.h),
                            itemBuilder: (context, index) {
                              if (index < products.length) {
                                final product = products[index];
                                return DisplayProductsWidget(product: product);
                              } else {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
        );
      },
    );
  }
}
