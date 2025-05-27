import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_task_products/features/products/domain/entities/product_entity.dart';
import 'package:my_task_products/features/products/domain/usecases/filter_products_use_case.dart';

part 'filter_products_state.dart';

class FilterProductsCubit extends Cubit<FilterProductsState> {
  FilterProductsCubit({required this.filterProductsUseCase})
    : super(FilterProductsInitial());
  final FilterProductsUseCase filterProductsUseCase;


  Future<void> filteringProducts({
    required String sortBy,
    required String order,
  }) async {
    emit(FilterProductsLoading());
    final response = await filterProductsUseCase.call(
      sortBy: sortBy,
      order: order,
    );
    emit(FilterProductsLoaded(products: response));
  }
}
