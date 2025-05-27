import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_products/features/products/domain/entities/product_entity.dart';
import 'package:my_task_products/features/products/domain/usecases/get_products_use_case.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.getProductsUseCase}) : super(ProductInitial());
  final GetProductsUseCase getProductsUseCase;

  int limit = 10;
  int skip = 0;
  List<ProductEntity> products = [];
  bool hasMoreData = true;
  bool isLoading = false;

  Future<void> getProducts() async {
    if (isLoading || !hasMoreData) return;

    isLoading = true;
    emit(ProductsLoading());

    try {
      final newProducts = await getProductsUseCase.call(
        limit: limit,
        skip: skip,
      );

      if (newProducts.isEmpty) {
        hasMoreData = false;
      } else {
        products.addAll(newProducts);
        skip += limit;
      }

      emit(ProductsLoaded(products: List<ProductEntity>.from(products)));
    } catch (e) {
      emit(ProductsError(message: e.toString()));
    } finally {
      isLoading = false;
    }
  }
}
