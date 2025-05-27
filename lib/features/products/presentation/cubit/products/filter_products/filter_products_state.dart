part of 'filter_products_cubit.dart';

sealed class FilterProductsState extends Equatable {
  const FilterProductsState();

  @override
  List<Object> get props => [];
}

final class FilterProductsInitial extends FilterProductsState {}





final class FilterProductsLoading extends FilterProductsState {}

final class FilterProductsLoaded extends FilterProductsState {
  final List<ProductEntity> products;

  const FilterProductsLoaded({required this.products});
  @override
  List<Object> get props => [products];
}

final class FilterProductsError extends FilterProductsState {
  final String message;

  const FilterProductsError({required this.message});
  @override
  List<Object> get props => [message];
}
