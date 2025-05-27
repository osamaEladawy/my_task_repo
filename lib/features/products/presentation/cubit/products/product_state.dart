part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}


class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<ProductEntity> products;

  const ProductsLoaded({required this.products});
  @override
  List<Object> get props => [products];
}

class ProductsError extends ProductState {
  final String message;

  const ProductsError({required this.message});
  @override
  List<Object> get props => [message];
}
