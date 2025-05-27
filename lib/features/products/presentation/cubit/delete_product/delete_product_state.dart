part of 'delete_product_cubit.dart';

sealed class DeleteProductState extends Equatable {
  const DeleteProductState();

  @override
  List<Object> get props => [];
}

final class DeleteProductInitial extends DeleteProductState {}

final class DeleteProductError extends DeleteProductState {
  final String message;

  const DeleteProductError({required this.message});
  @override
  List<Object> get props => [message];
}

final class DeleteProductSuccess extends DeleteProductState {
  final ProductModel productModel;

  const DeleteProductSuccess({required this.productModel});
  @override
  List<Object> get props => [productModel];
}
